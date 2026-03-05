defmodule Gateway.Core.Payments.Orchestrator do
  alias Gateway.Repo
  alias Gateway.Core.Payments.Payment
  alias Gateway.ProviderEngine.Dispatcher
  alias Gateway.Jobs.ProcessPaymentJob
  alias Gateway.Core.Payments.StateMachine

  def create_and_process(attrs, merchant_id, idempotency_key) do
    Repo.transaction(fn ->
      case Repo.get_by(Payment,
             merchant_id: merchant_id,
             idempotency_key: idempotency_key
           ) do
        nil ->
          create_new_payment(attrs, merchant_id, idempotency_key)

        existing ->
          existing
      end
    end)
  end

  defp create_new_payment(attrs, merchant_id, idempotency_key) do
    internal_reference = Ecto.UUID.generate()

    provider_id = Map.get(attrs, :provider_id) || Map.get(attrs, "provider_id")
    type = Map.get(attrs, :type) || Map.get(attrs, "type")
    amount = Map.get(attrs, :amount) || Map.get(attrs, "amount")
    currency = Map.get(attrs, :currency) || Map.get(attrs, "currency") || "XOF"
    phone_number = Map.get(attrs, :phone_number) || Map.get(attrs, "phone_number")
    metadata = Map.get(attrs, :metadata) || Map.get(attrs, "metadata")

    changeset =
      Payment.changeset(%Payment{}, %{
        merchant_id: merchant_id,
        provider_id: provider_id,
        type: type,
        amount: amount,
        currency: currency,
        status: :initiated,
        internal_reference: internal_reference,
        idempotency_key: idempotency_key,
        phone_number: phone_number,
        metadata: metadata
      })

    case Repo.insert(changeset) do
      {:ok, payment} ->
        route_payment(payment)

      {:error, changeset} ->
        Repo.rollback(changeset)
    end
  end

  defp route_payment(payment) do
    provider_module =
      Dispatcher.get_provider_module(payment.provider_id)

    case provider_module.provider_type() do
      :sync ->
        process_sync(payment, provider_module)

      :async ->
        enqueue_async(payment)
    end
  end

  defp process_sync(payment, provider_module) do
    with true <- StateMachine.can_transition?(:initiated, :processing),
         {:ok, response} <- provider_module.collect(payment) do
      Dispatcher.handle_provider_response(payment, response)
    end
  end

  defp enqueue_async(payment) do
    %{
      payment_id: payment.id
    }
    |> ProcessPaymentJob.new()
    |> Oban.insert()

    payment
  end
end
