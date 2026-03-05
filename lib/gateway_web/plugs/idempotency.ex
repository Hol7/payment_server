defmodule GatewayWeb.Plugs.Idempotency do
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _opts) do
    case get_req_header(conn, "idempotency-key") do
      [key] when byte_size(key) > 10 ->
        assign(conn, :idempotency_key, key)

      _ ->
        conn
        |> send_resp(400, "Missing or invalid Idempotency-Key header")
        |> halt()
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
