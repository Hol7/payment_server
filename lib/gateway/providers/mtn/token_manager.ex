defmodule Gateway.Providers.MTN.TokenManager do
  use GenServer

  # @token_url "https://sandbox.momodeveloper.mtn.com/collection/token/"

  # @config Application.compile_env(:gateway, Gateway.Providers.MTN)

  # @token_url @config[:base_url] <> @config[:collection_token_path]

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  def get_token do
    GenServer.call(__MODULE__, :get_token)
  end

  @impl true
  def init(_) do
    {:ok, %{token: nil, expires_at: 0}}
  end

  @impl true
  def handle_call(:get_token, _from, state) do
    if expired?(state) do
      {:ok, token, expires_in} = fetch_token()

      new_state = %{
        token: token,
        expires_at: System.system_time(:second) + expires_in - 60
      }

      {:reply, token, new_state}
    else
      {:reply, state.token, state}
    end
  end

  defp expired?(%{expires_at: expires_at}) do
    System.system_time(:second) >= expires_at
  end

  defp fetch_token do
    config = Application.fetch_env!(:gateway, Gateway.Providers.MTN)

    base_url = config[:base_url] || raise("MTN_BASE_URL is not configured")
    token_path = config[:collection_token_path] || "/collection/token/"
    subscription_key = System.fetch_env!("MTN_SUBSCRIPTION_KEY_COLLECTION")
    api_user = System.fetch_env!("MTN_API_USER")
    api_key = System.fetch_env!("MTN_API_KEY")

    basic = Base.encode64("#{api_user}:#{api_key}")

    headers = [
      {"Authorization", "Basic #{basic}"},
      {"Ocp-Apim-Subscription-Key", subscription_key}
    ]

    resp = Req.post!(base_url <> token_path, headers: headers)

    token = resp.body["access_token"]
    expires_in = resp.body["expires_in"]

    {:ok, token, expires_in}
  end
end
