defmodule Gateway.Repo.Migrations.CreateLedgerAccounts do
  use Ecto.Migration

  def change do
    create table(:ledger_accounts) do
      add :owner_type, :string
      add :owner_id, :uuid
      add :provider_id, :uuid
      add :currency, :string
      add :balance_cache, :decimal

      timestamps(type: :utc_datetime)
    end
  end
end
