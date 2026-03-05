defmodule Gateway.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string
      add :password_hash, :string
      add :merchant_id, :uuid
      add :role_id, :uuid

      timestamps(type: :utc_datetime)
    end
  end
end
