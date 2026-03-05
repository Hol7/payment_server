defmodule Gateway.Core.LedgerEntry do
  use Ecto.Schema
  import Ecto.Changeset

  schema "ledger_entries" do
    field :debit_account_id, Ecto.UUID
    field :credit_account_id, Ecto.UUID
    field :amount, :decimal
    field :payment_id, Ecto.UUID

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(ledger_entry, attrs) do
    ledger_entry
    |> cast(attrs, [:debit_account_id, :credit_account_id, :amount, :payment_id])
    |> validate_required([:debit_account_id, :credit_account_id, :amount, :payment_id])
  end
end
