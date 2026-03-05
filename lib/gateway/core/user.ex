defmodule Gateway.Core.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :password_hash, :string
    field :merchant_id, Ecto.UUID
    field :role_id, Ecto.UUID

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :password_hash, :merchant_id, :role_id])
    |> validate_required([:email, :password_hash, :merchant_id, :role_id])
  end
end
