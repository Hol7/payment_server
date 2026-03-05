defmodule Gateway.Repo.Migrations.CreateMerchantFeeConfigs do
  use Ecto.Migration

  def change do
    create table(:merchant_fee_configs) do
      add :merchant_id, :uuid
      add :provider_id, :uuid
      add :collection_percentage, :decimal
      add :disbursement_percentage, :decimal
      add :flat_fee, :decimal
      add :tax_percentage, :decimal
      add :active, :boolean, default: false, null: false

      timestamps(type: :utc_datetime)
    end
  end
end
