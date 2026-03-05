defmodule Gateway.Core.Merchants do
  import Ecto.Query, warn: false

  alias Gateway.Repo
  alias Gateway.Core.Merchants.Merchant

  def list_merchants do
    Repo.all(from m in Merchant, order_by: [asc: m.inserted_at])
  end

  def create_merchant(attrs) when is_map(attrs) do
    %Merchant{}
    |> Merchant.changeset(attrs)
    |> Repo.insert()
  end
end
