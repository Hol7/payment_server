defmodule GatewayWeb.Router do
  use GatewayWeb, :router

  import Phoenix.LiveView.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {GatewayWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  # pipeline :api do
  #   plug :accepts, ["json"]
  # end

  # scope "/api", GatewayWeb do
  #   pipe_through :api
  # end

  pipeline :api do
    plug :accepts, ["json"]
    plug GatewayWeb.Plugs.Idempotency
    plug GatewayWeb.Plugs.Authenticate
  end

  pipeline :graphiql do
    plug :accepts, ["html", "json"]
    plug GatewayWeb.Plugs.Idempotency
    plug GatewayWeb.Plugs.Authenticate
  end

  scope "/" do
    pipe_through :browser

    get "/", GatewayWeb.RootController, :index
  end

  scope "/api" do
    pipe_through :api

    # forward "/graphql",
    #         Absinthe.Plug,
    #         schema: GatewayWeb.Schema

    # forward "/graphql",
    #         Absinthe.Plug,
    #         schema: GatewayWeb.GraphQL.Schema

    # forward "/graphiql",
    #         Absinthe.Plug.GraphiQL,
    #         schema: GatewayWeb.GraphQL.Schema

    forward "/graphql",
            Absinthe.Plug,
            schema: GatewayWeb.GraphQL.Schema
  end

  scope "/api" do
    pipe_through :graphiql

    forward "/graphiql",
            Absinthe.Plug.GraphiQL,
            schema: GatewayWeb.GraphQL.Schema,
            interface: :simple,
            default_url: "/api/graphql"

    # post "/webhooks/mtn", WebhookController, :mtn
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:gateway, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: GatewayWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
