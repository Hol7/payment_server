defmodule Gateway.Repo.Migrations.AddPhoneNumberToPayments do
  use Ecto.Migration

  def change do
    alter table(:payments) do
      add :phone_number, :string
    end
  end
end
