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

    create index(:ledger_entries, [:payment_id])
    create index(:ledger_entries, [:debit_account_id])
    create index(:ledger_entries, [:credit_account_id])
  end
end
