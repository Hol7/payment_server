defmodule Gateway.Core.Payments.Payment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "payments" do
    field :amount, :decimal
    field :currency, :string
    field :status, Ecto.Enum,
      values: [:initiated, :processing, :pending, :awaiting_validation, :success, :failed, :cancelled]
    field :type, :string
    field :phone_number, :string

    field :internal_reference, :string
    field :external_reference, :string
    field :idempotency_key, :string
    field :metadata, :map

    field :provider_id, :integer

    belongs_to :merchant, Gateway.Core.Merchants.Merchant
    # belongs_to :provider, Gateway.Providers.Provider

    timestamps(type: :utc_datetime)
  end

  def changeset(payment, attrs) do
    payment
    |> cast(attrs, [
      :merchant_id,
      :provider_id,
      :amount,
      :currency,
      :status,
      :type,
      :phone_number,
      :internal_reference,
      :external_reference,
      :idempotency_key,
      :metadata
    ])
    |> validate_required([:merchant_id, :provider_id, :amount, :currency, :type, :status, :internal_reference, :idempotency_key])
  end
end
