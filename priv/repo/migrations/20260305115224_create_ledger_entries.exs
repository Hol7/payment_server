defmodule Gateway.Repo.Migrations.CreateLedgerEntries do
  use Ecto.Migration

  def change do
    create table(:ledger_entries) do
      add :debit_account_id, :uuid
      add :credit_account_id, :uuid
      add :amount, :decimal
      add :payment_id, :uuid

      timestamps(type: :utc_datetime)
    end
  end
end
