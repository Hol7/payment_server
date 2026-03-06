defmodule GatewayWeb.Plugs.Authenticate do
  @behaviour Plug

  import Plug.Conn
  import Ecto.Query, warn: false

  alias Gateway.Repo
  alias Gateway.Core.Merchants.Merchant

  def init(opts), do: opts

  def call(conn, _opts) do
    context = build_context(conn)

    Absinthe.Plug.put_options(conn, context: context)
  end

  defp build_context(conn) do
    idempotency_key = conn.assigns[:idempotency_key]

    base_context =
      if is_binary(idempotency_key) and byte_size(idempotency_key) > 0 do
        %{idempotency_key: idempotency_key}
      else
        %{}
      end

    with ["Bearer " <> api_key] <- get_req_header(conn, "authorization"),
         %Merchant{} = merchant <- Repo.one(from m in Merchant, where: m.api_key == ^api_key) do
      Map.put(base_context, :current_merchant, merchant)
    else
      _ ->
        base_context
    end
  end
end
