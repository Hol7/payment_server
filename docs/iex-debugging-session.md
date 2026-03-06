# IEx Debugging Session Log

## Environment Setup
```sh
# Start Phoenix server
mix phx.server

# Connect to live IEx node (if needed)
iex --remsh gateway
```

## Database and Oban Checks

### 1) Check Oban configuration
```elixir
Application.get_env(:gateway, Oban)
# => [repo: Gateway.Repo, queues: [payments: 50, reconciliation: 10], plugins: [Oban.Plugins.Pruner]]
```

### 2) Query Oban jobs (empty result)
```elixir
import Ecto.Query
alias Gateway.Repo
alias Oban.Job

Repo.all(from j in Job, order_by: [desc: j.id], limit: 5)
# => []
```

### 3) Manually insert and execute a job
```elixir
alias Gateway.Jobs.ProcessPaymentJob

Oban.insert!(ProcessPaymentJob.new(%{payment_id: 1}))
# => %Oban.Job{id: 2, state: "available", queue: "payments", worker: "Gateway.Jobs.ProcessPaymentJob", args: %{payment_id: 1}, ...}
# Job executed immediately; saw SELECT on payments table from ProcessPaymentJob.perform/1
```

## Payment and Provider Checks

### 4) Verify provider resolution
```elixir
Gateway.ProviderEngine.Dispatcher.get_provider_module(1)
# => Gateway.Providers.MTN.Adapter
```

### 5) Check payment status (still :initiated)
```elixir
alias Gateway.Core.Payments.Payment

Repo.get(Payment, 1)
# => %Payment{id: 1, amount: Decimal.new("1000"), currency: "XOF", status: :initiated, phone_number: "229XXXXXXXX", ...}
```

## MTN Adapter Debugging

### 6) Direct adapter call (failed due to missing env)
```elixir
alias Gateway.Providers.MTN.Adapter

payment = Repo.get!(Payment, 1)
Adapter.collect(payment)
# ** (RuntimeError) MTN_BASE_URL is not configured
```

## Resolution Steps

### Export environment variables before starting Phoenix
```sh
set -a
source .env
set +a
mix phx.server
```

### Verify env vars are loaded
```sh
echo $MTN_BASE_URL
echo $MTN_SUBSCRIPTION_KEY_COLLECTION
echo $MTN_API_USER
echo $MTN_API_KEY
```

### Retry adapter call after env is loaded
```elixir
# In IEx after restarting Phoenix with env vars
Adapter.collect(payment)
# Expected: {:ok, response} or {:error, reason}
```

## Expected Flow After Fix

1. `Adapter.collect/1` calls `TokenManager.get_token()` (real MTN token fetch)
2. Sends request-to-pay to MTN with the payment’s `phone_number`
3. Returns `{:ok, response}` with MTN transaction reference
4. `Dispatcher.handle_provider_response` updates payment status and sets `external_reference`

## Key Takeaways

- Oban is working; jobs execute immediately when inserted
- Original `createPayment` didn’t enqueue a job (likely due to missing env vars causing early failure)
- MTN adapter fails fast when `MTN_BASE_URL` is not configured
- Exporting `.env` before `mix phx.server` resolves the configuration issue
- After env fix, the full async flow should work: GraphQL → orchestrator → Oban job → MTN HTTP call → status update
