defmodule Gateway.Jobs.ProcessPaymentJob do
  use Oban.Worker, queue: :payments, max_attempts: 5

  alias Gateway.Repo
  alias Gateway.Core.Payments.Payment
  alias Gateway.ProviderEngine.Dispatcher

  @impl Oban.Worker
  def perform(%Oban.Job{args: %{"payment_id" => payment_id}}) do
    payment = Repo.get!(Payment, payment_id)

    provider_module =
      Dispatcher.get_provider_module(payment.provider_id)

    case provider_module.collect(payment) do
      {:ok, response} ->
        Dispatcher.handle_provider_response(payment, response)

      {:error, reason} ->
        {:error, reason}
    end
  end
end
