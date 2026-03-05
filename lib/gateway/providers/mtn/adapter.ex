defmodule Gateway.Providers.MTN.Adapter do
  @behaviour Gateway.ProviderEngine.Behaviour

  alias Gateway.Providers.MTN.TokenManager
  alias Gateway.Infra.HttpClient

  @base_url "https://sandbox.momodeveloper.mtn.com"

  @impl true
  def provider_type, do: :async

  @impl true
  def collect(payment) do
    token = TokenManager.get_token()

    headers = [
      {"Authorization", "Bearer #{token}"},
      {"Content-Type", "application/json"},
      {"X-Reference-Id", payment.internal_reference},
      {"X-Target-Environment", "sandbox"},
      {"Ocp-Apim-Subscription-Key", System.get_env("MTN_SUBSCRIPTION_KEY_COLLECTION")}
    ]

    body = %{
      amount: payment.amount,
      currency: payment.currency,
      externalId: payment.internal_reference,
      payer: %{
        partyIdType: "MSISDN",
        partyId: "22900000000"
      }
    }

    HttpClient.post("#{@base_url}/collection/v1_0/requesttopay", body, headers)
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
