defmodule GatewayWeb.GraphQL.Resolvers.MerchantResolver do
  alias Gateway.Core.Merchants
  # alias Gateway.Core.Merchants.Merchant

  def list_merchants(_, _, _) do
    {:ok, Merchants.list_merchants()}
  end

  def create_merchant(_, %{name: name}, _) do
    params = %{
      name: name,
      api_key: generate_api_key(),
      status: "active"
    }

    case Merchants.create_merchant(params) do
      {:ok, merchant} ->
        {:ok, merchant}

      {:error, _changeset} ->
        {:error, "Could not create merchant"}
    end
  end

  defp generate_api_key do
    :crypto.strong_rand_bytes(24)
    |> Base.encode16()
  end
end
