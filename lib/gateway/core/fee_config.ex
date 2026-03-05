defmodule Gateway.Core.FeeConfig do
  use Ecto.Schema
  import Ecto.Changeset

  schema "merchant_fee_configs" do
    field :merchant_id, Ecto.UUID
    field :provider_id, Ecto.UUID
    field :collection_percentage, :decimal
    field :disbursement_percentage, :decimal
    field :flat_fee, :decimal
    field :tax_percentage, :decimal
    field :active, :boolean, default: false

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(fee_config, attrs) do
    fee_config
    |> cast(attrs, [:merchant_id, :provider_id, :collection_percentage, :disbursement_percentage, :flat_fee, :tax_percentage, :active])
    |> validate_required([:merchant_id, :provider_id, :collection_percentage, :disbursement_percentage, :flat_fee, :tax_percentage, :active])
  end
end
