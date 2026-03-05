defmodule Gateway.Core.LedgerAccount do
  use Ecto.Schema
  import Ecto.Changeset

  schema "ledger_accounts" do
    field :owner_type, :string
    field :owner_id, Ecto.UUID
    field :provider_id, Ecto.UUID
    field :currency, :string
    field :balance_cache, :decimal

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(ledger_account, attrs) do
    ledger_account
    |> cast(attrs, [:owner_type, :owner_id, :provider_id, :currency, :balance_cache])
    |> validate_required([:owner_type, :owner_id, :provider_id, :currency, :balance_cache])
  end
end
