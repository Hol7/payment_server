defmodule Gateway.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children =
      [
        GatewayWeb.Telemetry,
        Gateway.Repo,
        {DNSCluster, query: Application.get_env(:gateway, :dns_cluster_query) || :ignore},
        {Phoenix.PubSub, name: Gateway.PubSub},
        Gateway.Providers.MTN.TokenManager,
        # Start a worker by calling: Gateway.Worker.start_link(arg)
        # {Gateway.Worker, arg},
        # Start to serve requests, typically the last entry
        GatewayWeb.Endpoint
      ]
      |> maybe_add_oban()

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Gateway.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp maybe_add_oban(children) do
    if Mix.env() == :test do
      children
    else
      List.insert_at(children, 2, {Oban, Application.fetch_env!(:gateway, Oban)})
    end
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    GatewayWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
