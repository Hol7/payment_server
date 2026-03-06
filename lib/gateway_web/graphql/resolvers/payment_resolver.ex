defmodule GatewayWeb.GraphQL.Resolvers.PaymentResolver do
  alias Gateway.Core.Payments

  def create_payment(_, args, %{context: %{current_merchant: merchant} = context}) do
    attrs =
      args
      |> Map.put(:merchant_id, merchant.id)
      |> maybe_put_idempotency_key(context)

    case Payments.create_payment(attrs) do
      {:ok, payment} ->
        {:ok, %{payment: payment}}

      {:error, :missing_merchant} ->
        {:error, "Missing merchant"}

      {:error, _reason} ->
        {:error, "Payment failed"}
    end
  end

  def create_payment(_, _args, _resolution) do
    {:error, "Unauthorized"}
  end

  defp maybe_put_idempotency_key(attrs, %{idempotency_key: key})
       when is_binary(key) and byte_size(key) > 0 do
    Map.put_new(attrs, :idempotency_key, key)
  end

  defp maybe_put_idempotency_key(attrs, _context), do: attrs
end
