defmodule GatewayWeb.RootController do
  use GatewayWeb, :controller

  def index(conn, _params) do
    redirect(conn, to: "/api/graphiql")
  end
end
