defmodule Gateway.Core.Payments do
  use Ecto.Schema
  import Ecto.Changeset

  schema "payment" do
    field :merchant_id, Ecto.UUID
    field :provider_id, Ecto.UUID
    field :type, :string
    field :amount, :integer
    field :currency, :string
    field :status, :string
    field :internal_reference, :string
    field :provider_reference, :string
    field :idempotency_key, :string
    field :metadata, :map

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(payments, attrs) do
    payments
    |> cast(attrs, [:merchant_id, :provider_id, :type, :amount, :currency, :status, :internal_reference, :provider_reference, :idempotency_key, :metadata])
    |> validate_required([:merchant_id, :provider_id, :type, :amount, :currency, :status, :internal_reference, :provider_reference, :idempotency_key])
  end
end
