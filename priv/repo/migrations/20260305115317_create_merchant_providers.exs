defmodule Gateway.Repo.Migrations.CreateMerchantProviders do
  use Ecto.Migration

  def change do
    create table(:merchant_providers) do
      add :merchant_id, :uuid
      add :provider_id, :uuid
      add :enabled, :boolean, default: false, null: false

      timestamps(type: :utc_datetime)
    end
  end
end
