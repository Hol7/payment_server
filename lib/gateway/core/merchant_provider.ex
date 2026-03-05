defmodule Gateway.Core.MerchantProvider do
  use Ecto.Schema
  import Ecto.Changeset

  schema "merchant_providers" do
    field :merchant_id, Ecto.UUID
    field :provider_id, Ecto.UUID
    field :enabled, :boolean, default: false

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(merchant_provider, attrs) do
    merchant_provider
    |> cast(attrs, [:merchant_id, :provider_id, :enabled])
    |> validate_required([:merchant_id, :provider_id, :enabled])
  end
end
