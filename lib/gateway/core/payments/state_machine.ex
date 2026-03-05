defmodule Gateway.Core.Payments.StateMachine do
  @valid_transitions %{
    initiated: [:processing, :pending, :awaiting_validation],
    processing: [:success, :failed],
    pending: [:success, :failed],
    awaiting_validation: [:processing, :cancelled]
  }

  def can_transition?(from, to) do
    to in Map.get(@valid_transitions, from, [])
  end
end
