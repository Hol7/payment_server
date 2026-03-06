defmodule GatewayWeb.GraphQL.Types.PaymentTypes do
  use Absinthe.Schema.Notation

  alias GatewayWeb.GraphQL.Resolvers.PaymentResolver

  object :payment do
    field :id, :id
    field :amount, :decimal
    field :currency, :string

    field :status, :string do
      resolve(fn payment, _, _ ->
        {:ok, payment.status && Atom.to_string(payment.status)}
      end)
    end
  end

  object :payment_response do
    field :payment, :payment
  end

  object :payment_mutations do
    field :create_payment, :payment_response do
      arg(:amount, non_null(:integer))
      arg(:currency, non_null(:string))

      resolve(&PaymentResolver.create_payment/3)
    end
  end
end
