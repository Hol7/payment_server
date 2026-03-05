defmodule Gateway.Jobs.ReconciliationJob do
  use Oban.Worker, queue: :reconciliation

  import Ecto.Query

  alias Gateway.Repo
  alias Gateway.Core.Payments.Payment

  @impl Oban.Worker
  def perform(_job) do
    payments =
      Repo.all(
        from p in Payment,
          where: p.status in ["processing", "pending"]
      )

    Enum.each(payments, fn payment ->
      reconcile(payment)
    end)

    :ok
  end

  defp reconcile(payment) do
    # Placeholder reconciliation logic
    IO.puts("Reconciling payment #{payment.id}")
  end
end
