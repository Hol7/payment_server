defmodule GatewayWeb.GraphQL.Types.LedgerTypes do
  use Absinthe.Schema.Notation

  object :ledger_account do
    field :id, :id
    field :owner_type, :string
    field :owner_id, :id
    field :currency, :string
    field :balance_cache, :integer
  end

  object :ledger_entry do
    field :id, :id
    field :amount, :integer
    field :currency, :string
    field :description, :string
    field :inserted_at, :datetime
  end
end
