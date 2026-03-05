defmodule Gateway.Core.Payments.PricingEngine do
  alias Decimal, as: D

  # 1.5%
  @platform_fee_rate D.new("0.015")
  # 18%
  @tax_rate D.new("0.18")

  def compute(payment) do
    amount = D.new(payment.amount)

    fee =
      amount
      |> D.mult(@platform_fee_rate)
      |> D.round(0)

    tax =
      fee
      |> D.mult(@tax_rate)
      |> D.round(0)

    total_fee = D.add(fee, tax)

    merchant_net =
      amount
      |> D.sub(total_fee)

    %{
      gross_amount: amount,
      fee: fee,
      tax: tax,
      total_fee: total_fee,
      merchant_net: merchant_net
    }
  end
end
