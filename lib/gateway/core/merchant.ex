defmodule Gateway.Core.Merchant do
  use Ecto.Schema
  import Ecto.Changeset

  schema "merchants" do
    field :name, :string
    field :api_key, :string
    field :status, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(merchant, attrs) do
    merchant
    |> cast(attrs, [:name, :api_key, :status])
    |> validate_required([:name, :api_key, :status])
  end
end
