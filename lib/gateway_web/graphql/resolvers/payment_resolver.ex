defmodule GatewayWeb.GraphQL.Resolvers.PaymentResolver do
  alias Gateway.Core.Payments

  def create_payment(_, args, _) do
    case Payments.create_payment(args) do
      {:ok, payment} ->
        {:ok, %{payment: payment}}

      {:error, _} ->
        {:error, "Payment failed"}
    end
  end
end
