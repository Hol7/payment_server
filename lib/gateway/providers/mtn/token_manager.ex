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
    # Call MTN token endpoint here
    {:ok, "mock_token", 3600}
  end
end
