defmodule Gateway.Core.Provider do
  use Ecto.Schema
  import Ecto.Changeset

  schema "providers" do
    field :name, :string
    field :type, :string
    field :active, :boolean, default: false

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(provider, attrs) do
    provider
    |> cast(attrs, [:name, :type, :active])
    |> validate_required([:name, :type, :active])
  end
end
