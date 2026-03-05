defmodule Gateway.CoreFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Gateway.Core` context.
  """

  @doc """
  Generate a payments.
  """
  def payments_fixture(attrs \\ %{}) do
    {:ok, payments} =
      attrs
      |> Enum.into(%{
        amount: 42,
        currency: "some currency",
        idempotency_key: "some idempotency_key",
        internal_reference: "some internal_reference",
        merchant_id: "7488a646-e31f-11e4-aace-600308960662",
        metadata: %{},
        provider_id: "7488a646-e31f-11e4-aace-600308960662",
        provider_reference: "some provider_reference",
        status: "some status",
        type: "some type"
      })
      |> Gateway.Core.create_payments()

    payments
  end

  @doc """
  Generate a ledger_account.
  """
  def ledger_account_fixture(attrs \\ %{}) do
    {:ok, ledger_account} =
      attrs
      |> Enum.into(%{
        balance_cache: "120.5",
        currency: "some currency",
        owner_id: "7488a646-e31f-11e4-aace-600308960662",
        owner_type: "some owner_type",
        provider_id: "7488a646-e31f-11e4-aace-600308960662"
      })
      |> Gateway.Core.create_ledger_account()

    ledger_account
  end

  @doc """
  Generate a ledger_entry.
  """
  def ledger_entry_fixture(attrs \\ %{}) do
    {:ok, ledger_entry} =
      attrs
      |> Enum.into(%{
        amount: "120.5",
        credit_account_id: "7488a646-e31f-11e4-aace-600308960662",
        debit_account_id: "7488a646-e31f-11e4-aace-600308960662",
        payment_id: "7488a646-e31f-11e4-aace-600308960662"
      })
      |> Gateway.Core.create_ledger_entry()

    ledger_entry
  end

  @doc """
  Generate a merchant.
  """
  def merchant_fixture(attrs \\ %{}) do
    {:ok, merchant} =
      attrs
      |> Enum.into(%{
        api_key: "some api_key",
        name: "some name",
        status: "some status"
      })
      |> Gateway.Core.create_merchant()

    merchant
  end

  @doc """
  Generate a merchant_provider.
  """
  def merchant_provider_fixture(attrs \\ %{}) do
    {:ok, merchant_provider} =
      attrs
      |> Enum.into(%{
        enabled: true,
        merchant_id: "7488a646-e31f-11e4-aace-600308960662",
        provider_id: "7488a646-e31f-11e4-aace-600308960662"
      })
      |> Gateway.Core.create_merchant_provider()

    merchant_provider
  end

  @doc """
  Generate a fee_config.
  """
  def fee_config_fixture(attrs \\ %{}) do
    {:ok, fee_config} =
      attrs
      |> Enum.into(%{
        active: true,
        collection_percentage: "120.5",
        disbursement_percentage: "120.5",
        flat_fee: "120.5",
        merchant_id: "7488a646-e31f-11e4-aace-600308960662",
        provider_id: "7488a646-e31f-11e4-aace-600308960662",
        tax_percentage: "120.5"
      })
      |> Gateway.Core.create_fee_config()

    fee_config
  end

  @doc """
  Generate a provider.
  """
  def provider_fixture(attrs \\ %{}) do
    {:ok, provider} =
      attrs
      |> Enum.into(%{
        active: true,
        name: "some name",
        type: "some type"
      })
      |> Gateway.Core.create_provider()

    provider
  end

  @doc """
  Generate a provider_credential.
  """
  def provider_credential_fixture(attrs \\ %{}) do
    {:ok, provider_credential} =
      attrs
      |> Enum.into(%{
        config_json: %{},
        provider_id: "7488a646-e31f-11e4-aace-600308960662"
      })
      |> Gateway.Core.create_provider_credential()

    provider_credential
  end

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        email: "some email",
        merchant_id: "7488a646-e31f-11e4-aace-600308960662",
        password_hash: "some password_hash",
        role_id: "7488a646-e31f-11e4-aace-600308960662"
      })
      |> Gateway.Core.create_user()

    user
  end

  @doc """
  Generate a permission.
  """
  def permission_fixture(attrs \\ %{}) do
    {:ok, permission} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Gateway.Core.create_permission()

    permission
  end

  @doc """
  Generate a role_permission.
  """
  def role_permission_fixture(attrs \\ %{}) do
    {:ok, role_permission} =
      attrs
      |> Enum.into(%{
        permission_id: "7488a646-e31f-11e4-aace-600308960662",
        role_id: "7488a646-e31f-11e4-aace-600308960662"
      })
      |> Gateway.Core.create_role_permission()

    role_permission
  end
end
