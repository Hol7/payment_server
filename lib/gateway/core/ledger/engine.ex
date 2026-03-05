defmodule Gateway.Core.Ledger.Engine do
  alias Gateway.Repo
  alias Gateway.Core.Ledger.Entry

  # def transfer(debit_account, credit_account, amount, payment_id) do
  #   Repo.transaction(fn ->
  #     Repo.insert!(%LedgerEntry{
  #       debit_account_id: debit_account,
  #       credit_account_id: credit_account,
  #       amount: amount,
  #       payment_id: payment_id
  #     })
  #   end)
  # end

  def settle(payment, pricing) do
    Repo.insert_all(Entry, [
      build_entry(payment, "merchant_wallet", pricing.merchant_net, :credit),
      build_entry(payment, "platform_revenue", pricing.total_fee, :credit),
      build_entry(payment, "clearing_account", pricing.gross_amount, :debit)
    ])
  end

  defp build_entry(payment, account, amount, type) do
    %{
      payment_id: payment.id,
      account: account,
      amount: amount,
      type: type,
      inserted_at: DateTime.utc_now(),
      updated_at: DateTime.utc_now()
    }
  end
end

# defmodule Gateway.Core.Ledger.Engine do
#   alias Gateway.Repo
#   alias Gateway.Core.LedgerEntry

#   def transfer(debit_account, credit_account, amount, payment_id) do
#     Repo.transaction(fn ->
#       Repo.insert!(%LedgerEntry{
#         debit_account_id: debit_account,
#         credit_account_id: credit_account,
#         amount: amount,
#         payment_id: payment_id
#       })
#     end)
#   end
# end
