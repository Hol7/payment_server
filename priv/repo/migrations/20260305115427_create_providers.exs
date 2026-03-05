defmodule Gateway.Repo.Migrations.CreateProviders do
  use Ecto.Migration

  def change do
    create table(:providers) do
      add :name, :string
      add :type, :string
      add :active, :boolean, default: false, null: false

      timestamps(type: :utc_datetime)
    end

    create unique_index(:providers, [:name])
  end
end
