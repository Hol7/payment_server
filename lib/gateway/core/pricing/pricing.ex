defmodule Gateway.Core.Pricing.Calculator do
  def calculate(amount, fee_config) do
    commission =
      Decimal.mult(amount, fee_config.collection_percentage)
      |> Decimal.div(100)

    tax =
      Decimal.mult(commission, fee_config.tax_percentage)
      |> Decimal.div(100)

    %{
      commission: commission,
      tax: tax,
      net_to_merchant: amount - commission
    }
  end
end
