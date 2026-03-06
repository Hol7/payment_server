# GraphiQL Playground Examples

## Base URL
http://localhost:4000/api/graphiql

## 1. Create a Merchant
```graphql
mutation CreateMerchant {
  createMerchant(name: "Test Shop") {
    id
    name
    api_key
    inserted_at
  }
}
```

## 2. Create a Payment (requires Authorization Bearer header)
```graphql
mutation CreatePayment {
  createPayment(amount: 1000, currency: "XOF", phoneNumber: "229XXXXXXXX") {
    id
    amount
    currency
    status
    phone_number
    internal_reference
    external_reference
    idempotency_key
    provider_id
    merchant_id
    inserted_at
  }
}
```

### HTTP Headers
Set the following in GraphiQL Headers panel:
```json
{
  "Authorization": "Bearer <merchant_api_key_from_createMerchant>"
}
```

## 3. List Merchants
```graphql
query ListMerchants {
  merchants {
    id
    name
    api_key
    inserted_at
  }
}
```

## 4. Query a Payment by ID (replace :1 with actual payment ID)
```graphql
query GetPayment($id: ID!) {
  payment(id: $id) {
    id
    amount
    currency
    status
    phone_number
    internal_reference
    external_reference
    idempotency_key
    provider_id
    merchant_id
    inserted_at
    updated_at
  }
}
```

### Variables for GetPayment
```json
{
  "id": "1"
}
```

## 5. List All Payments
```graphql
query ListPayments {
  payments {
    id
    amount
    currency
    status
    phone_number
    internal_reference
    external_reference
    provider_id
    merchant_id
    inserted_at
  }
}
```

## Quick Test Workflow

1. **Create Merchant** → Copy the `api_key` from response
2. **Set Authorization Header** in GraphiQL: `"Authorization": "Bearer <api_key>"`
3. **Create Payment** → Note the `id` and `internal_reference`
4. **Query Payment** → Use the payment `id` to check status updates
5. **Check Database** (optional): In IEx, `Repo.all(Gateway.Core.Payments.Payment)`

## Expected Status Flow

- Initial: `status: :initiated`
- After Oban job runs: `status: :processing` or `:success` or `:failed`
- If MTN succeeds: `status: :success` with `external_reference` populated
- If MTN fails: `status: :failed` with error details in `metadata`

## Troubleshooting

- If `createPayment` returns an error, ensure the Authorization header is set with a valid merchant API key
- If payment stays `:initiated`, check Oban jobs in IEx: `Repo.all(Oban.Job)`
- If MTN call fails, verify environment variables are loaded: `echo $MTN_BASE_URL`
