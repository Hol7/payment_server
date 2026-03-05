defmodule Gateway.Core.ProviderCredential do
  use Ecto.Schema
  import Ecto.Changeset

  schema "provider_credentials" do
    field :provider_id, Ecto.UUID
    field :config_json, :map

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(provider_credential, attrs) do
    provider_credential
    |> cast(attrs, [:provider_id, :config_json])
    |> validate_required([:provider_id])
  end
end
