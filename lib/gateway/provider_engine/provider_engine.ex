defmodule Gateway.ProviderEngine.Behaviour do
  @callback collect(map()) ::
              {:ok, map()} | {:error, term()}

  @callback disburse(map()) ::
              {:ok, map()} | {:error, term()}

  @callback handle_webhook(map()) ::
              {:ok, map()} | {:error, term()}

  @callback provider_type() :: :sync | :async
end
