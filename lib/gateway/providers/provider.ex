defmodule Gateway.Providers.Provider do
  @callback collection(map()) :: {:ok, map()} | {:error, map()}
  @callback disbursement(map()) :: {:ok, map()} | {:error, map()}
  @callback check_status(map()) :: {:ok, map()} | {:error, map()}
end
