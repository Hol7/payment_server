defmodule Gateway.Core.Ledger.Entry do
  use Ecto.Schema
  import Ecto.Changeset

  schema "ledger_entries" do
    field :amount, :decimal
    field :currency, :string

    belongs_to :payment, Gateway.Core.Payments.Payment

    timestamps(type: :utc_datetime)
  end

  def changeset(entry, attrs) do
    entry
    |> cast(attrs, [:amount, :currency])
  end
end
