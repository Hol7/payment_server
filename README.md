# Gateway

## Overview

This is a Phoenix (Bandit) application that exposes its public API via **GraphQL (Absinthe)**.

## Architecture (high level)

- **`lib/gateway_web/`**
  - **`endpoint.ex`**
    - HTTP entrypoint. Runs common plugs (parsers, sessions, etc.) then dispatches to the router.
  - **`router.ex`**
    - Defines the public routes:
      - `GET /` redirects to GraphiQL for local exploration.
      - `/api/graphql` forwards to `Absinthe.Plug` (GraphQL execution endpoint).
      - `/api/graphiql` forwards to `Absinthe.Plug.GraphiQL` (browser IDE).
  - **`graphql/`**
    - `schema.ex` and GraphQL types/resolvers.
  - **`plugs/`**
    - Request middleware, including idempotency key handling.

- **`lib/gateway/`**
  - **Contexts (business API)**
    - `Gateway.Core.Merchants` and `Gateway.Core.Payments`
  - **Schemas (Ecto)**
    - `Gateway.Core.Payments.Payment` and merchant schemas
  - **Jobs (Oban)**
    - async processing for payments
  - **Providers**
    - provider adapters (e.g. MTN)
  - **Infra**
    - `Gateway.Infra.HttpClient` (uses `Req`)

## Requirements

- Elixir + Erlang (OTP)
- Postgres

## Running locally (mix)

1. Install deps:

```sh
mix deps.get
```

2. Create DB and run migrations:

```sh
mix ecto.create
mix ecto.migrate
```

3. Start the server:

```sh
mix phx.server
```

4. Open GraphiQL:

- http://127.0.0.1:4000/
- http://127.0.0.1:4000/api/graphiql

Note: if `http://localhost:4000` behaves differently than `http://127.0.0.1:4000`, you likely have another process (e.g. Docker) bound to port `4000` on IPv6.

## Tests

```sh
mix test
```

## Environment variables

Database configuration can be overridden with:

- `DB_HOST`
- `DB_USER`
- `DB_PASS`
- `DB_NAME`

Provider configuration (MTN) uses env vars such as:

- `MTN_BASE_URL`
- `MTN_TARGET_ENV`
- `MTN_SUBSCRIPTION_KEY_COLLECTION`

## Public API (GraphQL)

HTTP endpoints:

- `POST /api/graphql` (execute queries/mutations)
- `GET /api/graphiql` (GraphiQL IDE)

### Queries

- `merchants`

### Mutations

- `createMerchant(name: String!)`
- `createPayment(amount: Int!, currency: String!)`

### Curl examples

All GraphQL calls go to `POST /api/graphql`.

Create a merchant:

```sh
curl -s \
  -X POST http://127.0.0.1:4000/api/graphql \
  -H 'content-type: application/json' \
  -d '{"query":"mutation { createMerchant(name: \"Demo Merchant\") { id name apiKey status insertedAt } }"}'
```

List merchants:

```sh
curl -s \
  -X POST http://127.0.0.1:4000/api/graphql \
  -H 'content-type: application/json' \
  -d '{"query":"query { merchants { id name apiKey status insertedAt } }"}'
```

Create a payment:

```sh
curl -s \
  -X POST http://127.0.0.1:4000/api/graphql \
  -H 'content-type: application/json' \
  -d '{"query":"mutation { createPayment(amount: 1000, currency: \"XOF\") { payment { id amount currency status } } }"}'
```

### Token generation

There is **no public HTTP endpoint** that returns an MTN collection token.
Tokens are fetched and cached internally by the provider token manager when provider calls are performed.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

* Official website: https://www.phoenixframework.org/
* Guides: https://hexdocs.pm/phoenix/overview.html
* Docs: https://hexdocs.pm/phoenix
* Forum: https://elixirforum.com/c/phoenix-forum
* Source: https://github.com/phoenixframework/phoenix
