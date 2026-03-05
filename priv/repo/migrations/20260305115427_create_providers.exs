defmodule Gateway.Repo.Migrations.CreateProviders do
  use Ecto.Migration

  def change do
    create table(:providers) do
      add :name, :string
      add :type, :string
      add :active, :boolean, default: false, null: false

      timestamps(type: :utc_datetime)
    end
  end
end
