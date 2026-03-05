defmodule Gateway.Core.Payments do
  import Ecto.Query, warn: false

  alias Gateway.Repo
  alias Gateway.Core.Payments.Orchestrator
  alias Gateway.Core.Payments.Payment
  alias Gateway.Core.Merchants.Merchant

  def create_payment(attrs) when is_map(attrs) do
    merchant = Repo.one(from m in Merchant, order_by: [asc: m.inserted_at], limit: 1)

    merchant =
      case merchant do
        %Merchant{} = merchant ->
          merchant

        nil ->
          {:ok, merchant} =
            %Merchant{}
            |> Merchant.changeset(%{
              name: "Default Merchant",
              api_key: generate_api_key(),
              status: "active"
            })
            |> Repo.insert()

          merchant
      end

    idempotency_key = Map.get(attrs, :idempotency_key) || Map.get(attrs, "idempotency_key")

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

    case Orchestrator.create_and_process(payload, merchant.id, idempotency_key) do
      {:ok, %Payment{} = payment} -> {:ok, payment}
      {:error, reason} -> {:error, reason}
    end
  end

  defp generate_api_key do
    :crypto.strong_rand_bytes(24)
    |> Base.encode16()
  end
end
