defmodule Gateway.Repo.Migrations.CreateMerchants do
  use Ecto.Migration

  def change do
    create table(:merchants) do
      add :name, :string
      add :api_key, :string
      add :status, :string

      timestamps(type: :utc_datetime)
    end
  end
end
