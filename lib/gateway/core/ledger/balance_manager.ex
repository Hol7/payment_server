defmodule Gateway.Core.Ledger.BalanceManager do
  alias Gateway.Repo
  alias Gateway.Core.Ledger.Account

  def update_balance(account_id, amount) do
    account = Repo.get!(Account, account_id)

    new_balance = Decimal.add(account.balance_cache, amount)

    account
    |> Ecto.Changeset.change(balance_cache: new_balance)
    |> Repo.update()
  end
end
