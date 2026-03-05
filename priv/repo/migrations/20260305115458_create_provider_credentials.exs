defmodule Gateway.Repo.Migrations.CreateProviderCredentials do
  use Ecto.Migration

  def change do
    create table(:provider_credentials) do
      add :provider_id, :uuid
      add :config_json, :map

      timestamps(type: :utc_datetime)
    end
  end
end
