defmodule Gateway.Core.RolePermission do
  use Ecto.Schema
  import Ecto.Changeset

  schema "role_permissions" do
    field :role_id, Ecto.UUID
    field :permission_id, Ecto.UUID

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(role_permission, attrs) do
    role_permission
    |> cast(attrs, [:role_id, :permission_id])
    |> validate_required([:role_id, :permission_id])
  end
end
