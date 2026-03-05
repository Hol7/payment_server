defmodule Gateway.Repo.Migrations.CreatePayment do
  use Ecto.Migration

  def change do
    create table(:payments) do
      add :merchant_id, :bigint, null: false
      add :provider_id, :integer, null: false
      add :type, :string
      add :amount, :decimal
      add :currency, :string
      add :status, :string
      add :internal_reference, :string
      add :external_reference, :string
      add :idempotency_key, :string
      add :metadata, :map

      timestamps(type: :utc_datetime)
    end

    create unique_index(:payments, [:merchant_id, :idempotency_key])
    create unique_index(:payments, [:internal_reference])
    create index(:payments, [:provider_id])
    create index(:payments, [:status])
  end
end
