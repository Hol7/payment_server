defmodule Gateway.Repo.Migrations.CreateRolePermissions do
  use Ecto.Migration

  def change do
    create table(:role_permissions) do
      add :role_id, :uuid
      add :permission_id, :uuid

      timestamps(type: :utc_datetime)
    end
  end
end
