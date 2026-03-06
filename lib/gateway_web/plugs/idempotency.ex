defmodule GatewayWeb.Plugs.Idempotency do
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _opts) do
    case get_req_header(conn, "idempotency-key") do
      [key] when byte_size(key) > 0 ->
        assign(conn, :idempotency_key, key)

      _ ->
        key = Ecto.UUID.generate()

        conn
        |> put_resp_header("idempotency-key", key)
        |> assign(:idempotency_key, key)
    end
  end
end

# defmodule GatewayWeb.Plugs.Idempotency do
#   import Plug.Conn

#   def init(opts), do: opts

#   def call(conn, _opts) do
#     case get_req_header(conn, "idempotency-key") do
#       [key] ->
#         assign(conn, :idempotency_key, key)

#       _ ->
#         conn
#         |> send_resp(400, "Missing Idempotency-Key")
#         |> halt()
#     end
#   end
# end
