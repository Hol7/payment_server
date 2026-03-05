defmodule GatewayWeb.Plugs.RateLimit do
  # import Plug.Conn

  def init(opts), do: opts

  def call(conn, _opts) do
    conn
  end
end
