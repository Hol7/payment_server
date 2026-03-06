defmodule Gateway.Core.Payments do
  import Ecto.Query, warn: false

  alias Gateway.Core.Payments.Orchestrator
  alias Gateway.Core.Payments.Payment

  def create_payment(attrs) when is_map(attrs) do
    merchant_id = Map.get(attrs, :merchant_id) || Map.get(attrs, "merchant_id")
    idempotency_key = Map.get(attrs, :idempotency_key) || Map.get(attrs, "idempotency_key")

    if is_nil(merchant_id) do
      {:error, :missing_merchant}
    else
      do_create_payment(attrs, merchant_id, idempotency_key)
    end
  end

  defp do_create_payment(attrs, merchant_id, idempotency_key) do
    idempotency_key =
      case idempotency_key do
        key when is_binary(key) and byte_size(key) > 0 -> key
        _ -> Ecto.UUID.generate()
      end

    payload = %{
      amount: Map.get(attrs, :amount) || Map.get(attrs, "amount"),
      currency: Map.get(attrs, :currency) || Map.get(attrs, "currency") || "XOF",
      type: Map.get(attrs, :type) || Map.get(attrs, "type") || "collection",
      provider_id: Map.get(attrs, :provider_id) || Map.get(attrs, "provider_id") || 1,
      phone_number: Map.get(attrs, :phone_number) || Map.get(attrs, "phone_number"),
      metadata: Map.get(attrs, :metadata) || Map.get(attrs, "metadata")
    }

    case Orchestrator.create_and_process(payload, merchant_id, idempotency_key) do
      {:ok, %Payment{} = payment} -> {:ok, payment}
      {:error, reason} -> {:error, reason}
    end
  end
end
