defmodule Gateway.Core.Merchants.PricingRule do
  use Ecto.Schema

  schema "merchant_pricing_rules" do
    field :transaction_type, :string
    field :fee_percent, :decimal
    field :tax_percent, :decimal
    field :fixed_fee, :decimal

    belongs_to :merchant, Gateway.Core.Merchants.Merchant

    timestamps(type: :utc_datetime)
  end
end
