defmodule Gateway.ProviderEngine.Dispatcher do
  alias Gateway.Repo
  alias Gateway.Core.Payments.Payment
  alias Gateway.Core.Payments.StateMachine
  alias Gateway.Core.Payments.PricingEngine
  alias Gateway.Core.Ledger.Engine, as: LedgerEngine

  @providers %{
    1 => Gateway.Providers.MTN.Adapter,
    2 => Gateway.Providers.Moov.Adapter,
    3 => Gateway.Providers.Togocel.Adapter
  }

  def get_provider_module(provider_id) do
    Map.fetch!(@providers, provider_id)
  end

  # HANDLE PROVIDER RESPONSE

  def handle_provider_response(payment, response) do
    Repo.transaction(fn ->
      case map_provider_status(response) do
        :success ->
          handle_success(payment, response)

        :failed ->
          handle_failure(payment, response)

        :pending ->
          transition(payment, :pending)
      end
    end)
  end

  # SUCCESS FLOW

  defp handle_success(payment, _response) do
    transition(payment, :success)

    pricing = PricingEngine.compute(payment)

    LedgerEngine.settle(payment, pricing)

    payment
  end

  # FAILURE FLOW

  defp handle_failure(payment, _response) do
    transition(payment, :failed)
  end

  # STATE TRANSITION SAFE

  defp transition(payment, new_state) do
    if StateMachine.can_transition?(payment.status, new_state) do
      payment
      |> Payment.changeset(%{status: new_state})
      |> Repo.update!()
    else
      Repo.rollback("Invalid state transition")
    end
  end

  # PROVIDER STATUS MAPPING

  defp map_provider_status(%{"status" => "SUCCESSFUL"}), do: :success
  defp map_provider_status(%{"status" => "FAILED"}), do: :failed
  defp map_provider_status(_), do: :pending

  # WEBHOOK HANDLER

  def handle_webhook(:mtn, payload) do
    payment =
      Repo.get_by!(Payment,
        internal_reference: payload["externalId"]
      )

    handle_provider_response(payment, payload)
  end
end
