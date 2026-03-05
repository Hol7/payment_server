defmodule GatewayWeb.WebhookController do
  use GatewayWeb, :controller

  alias Gateway.ProviderEngine.Dispatcher

  def mtn(conn, payload) do
    case Dispatcher.handle_webhook(:mtn, payload) do
      {:ok, _} ->
        send_resp(conn, 200, "OK")

      {:error, _} ->
        send_resp(conn, 400, "Invalid")
    end
  end
end

# defmodule GatewayWeb.WebhookController do
#   use GatewayWeb, :controller

#   def mtn_webhook(conn, params) do
#     IO.inspect(params, label: "MTN WEBHOOK")

#     send_resp(conn, 200, "ok")
#   end
# end
