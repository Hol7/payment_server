defmodule GatewayWeb.GraphQL.Schema do
  use Absinthe.Schema

  import_types(Absinthe.Type.Custom)

  import_types(GatewayWeb.GraphQL.Types.PaymentTypes)
  import_types(GatewayWeb.GraphQL.Types.MerchantTypes)
  import_types(GatewayWeb.GraphQL.Types.LedgerTypes)

  query do
    import_fields(:merchant_queries)
  end

  mutation do
    import_fields(:payment_mutations)
    import_fields(:merchant_mutations)
  end
end

# defmodule GatewayWeb.GraphQL.Schema do
#   use Absinthe.Schema

#   import_types(GatewayWeb.GraphQL.Types.PaymentTypes)

#   query do
#     field :health, :string do
#       resolve(fn _, _, _ ->
#         {:ok, "Gateway running"}
#       end)
#     end
#   end

#   mutation do
#     import_fields(:payment_mutations)
#   end
# end
