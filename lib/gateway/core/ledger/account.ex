defmodule Gateway.Core.Ledger.Account do
  use Ecto.Schema
  import Ecto.Changeset

  schema "ledger_accounts" do
    field :owner_type, :string
    field :owner_id, Ecto.UUID
    field :currency, :string
    field :balance_cache, :decimal

    timestamps(type: :utc_datetime)
  end

  def changeset(account, attrs) do
    account
    |> cast(attrs, [:owner_type, :owner_id, :currency, :balance_cache])
  end
end
