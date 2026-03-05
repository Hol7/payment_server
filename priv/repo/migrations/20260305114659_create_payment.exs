defmodule Gateway.Repo.Migrations.CreatePayment do
  use Ecto.Migration

  def change do
    create table(:payment) do
      add :merchant_id, :uuid
      add :provider_id, :uuid
      add :type, :string
      add :amount, :integer
      add :currency, :string
      add :status, :string
      add :internal_reference, :string
      add :provider_reference, :string
      add :idempotency_key, :string
      add :metadata, :map

      timestamps(type: :utc_datetime)
    end
  end
end
