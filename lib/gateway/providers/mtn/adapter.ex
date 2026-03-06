defmodule Gateway.Providers.MTN.Adapter do
  @behaviour Gateway.ProviderEngine.Behaviour

  alias Gateway.Providers.MTN.TokenManager
  alias Gateway.Infra.HttpClient

  @impl true
  def provider_type, do: :async

  @impl true
  def collect(payment) do
    config = Application.fetch_env!(:gateway, Gateway.Providers.MTN)

    base_url = config[:base_url] || raise("MTN_BASE_URL is not configured")
    request_path = config[:collection_request_path] || "/collection/v1_0/requesttopay"

    target_environment =
      config[:target_environment] || System.get_env("MTN_TARGET_ENV") || "sandbox"

    token = TokenManager.get_token()

    headers = [
      {"Authorization", "Bearer #{token}"},
      {"Content-Type", "application/json"},
      {"X-Reference-Id", payment.internal_reference},
      {"X-Target-Environment", target_environment},
      {"Ocp-Apim-Subscription-Key", System.get_env("MTN_SUBSCRIPTION_KEY_COLLECTION")}
    ]

    body = %{
      amount: payment.amount,
      currency: payment.currency,
      externalId: payment.internal_reference,
      payer: %{
        partyIdType: "MSISDN",
        partyId: payment.phone_number
      }
    }

    HttpClient.post(base_url <> request_path, body, headers)
  end

  @impl true
  def disburse(_payment), do: {:error, :not_implemented}

  @impl true
  def handle_webhook(payload), do: {:ok, payload}
end

# def collect(payment) do
#   # build MTN payload
#   # call HTTP
#   # return normalized response
# end
