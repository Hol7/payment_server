defmodule GatewayWeb.GraphQL.Types.MerchantTypes do
  use Absinthe.Schema.Notation

  alias GatewayWeb.GraphQL.Resolvers.MerchantResolver

  object :merchant do
    field :id, :id
    field :name, :string
    field :api_key, :string
    field :status, :string
    field :inserted_at, :datetime
  end

  object :merchant_queries do
    field :merchants, list_of(:merchant) do
      resolve(&MerchantResolver.list_merchants/3)
    end
  end

  object :merchant_mutations do
    field :create_merchant, :merchant do
      arg(:name, non_null(:string))

      resolve(&MerchantResolver.create_merchant/3)
    end
  end
end
