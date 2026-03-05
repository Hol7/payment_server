defmodule Gateway.CoreTest do
  use Gateway.DataCase

  alias Gateway.Core

  describe "payment" do
    alias Gateway.Core.Payments

    import Gateway.CoreFixtures

    @invalid_attrs %{
      status: nil,
      type: nil,
      metadata: nil,
      currency: nil,
      amount: nil,
      merchant_id: nil,
      provider_id: nil,
      internal_reference: nil,
      provider_reference: nil,
      idempotency_key: nil
    }

    test "list_payment/0 returns all payment" do
      payments = payments_fixture()
      assert Core.list_payment() == [payments]
    end

    test "get_payments!/1 returns the payments with given id" do
      payments = payments_fixture()
      assert Core.get_payments!(payments.id) == payments
    end

    test "create_payments/1 with valid data creates a payments" do
      valid_attrs = %{
        status: "some status",
        type: "some type",
        metadata: %{},
        currency: "some currency",
        amount: 42,
        merchant_id: "7488a646-e31f-11e4-aace-600308960662",
        provider_id: "7488a646-e31f-11e4-aace-600308960662",
        internal_reference: "some internal_reference",
        provider_reference: "some provider_reference",
        idempotency_key: "some idempotency_key"
      }

      assert {:ok, %Payments{} = payments} = Core.create_payments(valid_attrs)
      assert payments.status == "some status"
      assert payments.type == "some type"
      assert payments.metadata == %{}
      assert payments.currency == "some currency"
      assert payments.amount == 42
      assert payments.merchant_id == "7488a646-e31f-11e4-aace-600308960662"
      assert payments.provider_id == "7488a646-e31f-11e4-aace-600308960662"
      assert payments.internal_reference == "some internal_reference"
      assert payments.provider_reference == "some provider_reference"
      assert payments.idempotency_key == "some idempotency_key"
    end

    test "create_payments/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Core.create_payments(@invalid_attrs)
    end

    test "update_payments/2 with valid data updates the payments" do
      payments = payments_fixture()

      update_attrs = %{
        status: "some updated status",
        type: "some updated type",
        metadata: %{},
        currency: "some updated currency",
        amount: 43,
        merchant_id: "7488a646-e31f-11e4-aace-600308960668",
        provider_id: "7488a646-e31f-11e4-aace-600308960668",
        internal_reference: "some updated internal_reference",
        provider_reference: "some updated provider_reference",
        idempotency_key: "some updated idempotency_key"
      }

      assert {:ok, %Payments{} = payments} = Core.update_payments(payments, update_attrs)
      assert payments.status == "some updated status"
      assert payments.type == "some updated type"
      assert payments.metadata == %{}
      assert payments.currency == "some updated currency"
      assert payments.amount == 43
      assert payments.merchant_id == "7488a646-e31f-11e4-aace-600308960668"
      assert payments.provider_id == "7488a646-e31f-11e4-aace-600308960668"
      assert payments.internal_reference == "some updated internal_reference"
      assert payments.provider_reference == "some updated provider_reference"
      assert payments.idempotency_key == "some updated idempotency_key"
    end

    test "update_payments/2 with invalid data returns error changeset" do
      payments = payments_fixture()
      assert {:error, %Ecto.Changeset{}} = Core.update_payments(payments, @invalid_attrs)
      assert payments == Core.get_payments!(payments.id)
    end

    test "delete_payments/1 deletes the payments" do
      payments = payments_fixture()
      assert {:ok, %Payments{}} = Core.delete_payments(payments)
      assert_raise Ecto.NoResultsError, fn -> Core.get_payments!(payments.id) end
    end

    test "change_payments/1 returns a payments changeset" do
      payments = payments_fixture()
      assert %Ecto.Changeset{} = Core.change_payments(payments)
    end
  end

  describe "ledger_accounts" do
    alias Gateway.Core.LedgerAccount

    import Gateway.CoreFixtures

    @invalid_attrs %{
      currency: nil,
      owner_type: nil,
      owner_id: nil,
      provider_id: nil,
      balance_cache: nil
    }

    test "list_ledger_accounts/0 returns all ledger_accounts" do
      ledger_account = ledger_account_fixture()
      assert Core.list_ledger_accounts() == [ledger_account]
    end

    test "get_ledger_account!/1 returns the ledger_account with given id" do
      ledger_account = ledger_account_fixture()
      assert Core.get_ledger_account!(ledger_account.id) == ledger_account
    end

    test "create_ledger_account/1 with valid data creates a ledger_account" do
      valid_attrs = %{
        currency: "some currency",
        owner_type: "some owner_type",
        owner_id: "7488a646-e31f-11e4-aace-600308960662",
        provider_id: "7488a646-e31f-11e4-aace-600308960662",
        balance_cache: "120.5"
      }

      assert {:ok, %LedgerAccount{} = ledger_account} = Core.create_ledger_account(valid_attrs)
      assert ledger_account.currency == "some currency"
      assert ledger_account.owner_type == "some owner_type"
      assert ledger_account.owner_id == "7488a646-e31f-11e4-aace-600308960662"
      assert ledger_account.provider_id == "7488a646-e31f-11e4-aace-600308960662"
      assert ledger_account.balance_cache == Decimal.new("120.5")
    end

    test "create_ledger_account/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Core.create_ledger_account(@invalid_attrs)
    end

    test "update_ledger_account/2 with valid data updates the ledger_account" do
      ledger_account = ledger_account_fixture()

      update_attrs = %{
        currency: "some updated currency",
        owner_type: "some updated owner_type",
        owner_id: "7488a646-e31f-11e4-aace-600308960668",
        provider_id: "7488a646-e31f-11e4-aace-600308960668",
        balance_cache: "456.7"
      }

      assert {:ok, %LedgerAccount{} = ledger_account} =
               Core.update_ledger_account(ledger_account, update_attrs)

      assert ledger_account.currency == "some updated currency"
      assert ledger_account.owner_type == "some updated owner_type"
      assert ledger_account.owner_id == "7488a646-e31f-11e4-aace-600308960668"
      assert ledger_account.provider_id == "7488a646-e31f-11e4-aace-600308960668"
      assert ledger_account.balance_cache == Decimal.new("456.7")
    end

    test "update_ledger_account/2 with invalid data returns error changeset" do
      ledger_account = ledger_account_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Core.update_ledger_account(ledger_account, @invalid_attrs)

      assert ledger_account == Core.get_ledger_account!(ledger_account.id)
    end

    test "delete_ledger_account/1 deletes the ledger_account" do
      ledger_account = ledger_account_fixture()
      assert {:ok, %LedgerAccount{}} = Core.delete_ledger_account(ledger_account)
      assert_raise Ecto.NoResultsError, fn -> Core.get_ledger_account!(ledger_account.id) end
    end

    test "change_ledger_account/1 returns a ledger_account changeset" do
      ledger_account = ledger_account_fixture()
      assert %Ecto.Changeset{} = Core.change_ledger_account(ledger_account)
    end
  end

  describe "ledger_entries" do
    alias Gateway.Core.LedgerEntry

    import Gateway.CoreFixtures

    @invalid_attrs %{amount: nil, debit_account_id: nil, credit_account_id: nil, payment_id: nil}

    test "list_ledger_entries/0 returns all ledger_entries" do
      ledger_entry = ledger_entry_fixture()
      assert Core.list_ledger_entries() == [ledger_entry]
    end

    test "get_ledger_entry!/1 returns the ledger_entry with given id" do
      ledger_entry = ledger_entry_fixture()
      assert Core.get_ledger_entry!(ledger_entry.id) == ledger_entry
    end

    test "create_ledger_entry/1 with valid data creates a ledger_entry" do
      valid_attrs = %{
        amount: "120.5",
        debit_account_id: "7488a646-e31f-11e4-aace-600308960662",
        credit_account_id: "7488a646-e31f-11e4-aace-600308960662",
        payment_id: "7488a646-e31f-11e4-aace-600308960662"
      }

      assert {:ok, %LedgerEntry{} = ledger_entry} = Core.create_ledger_entry(valid_attrs)
      assert ledger_entry.amount == Decimal.new("120.5")
      assert ledger_entry.debit_account_id == "7488a646-e31f-11e4-aace-600308960662"
      assert ledger_entry.credit_account_id == "7488a646-e31f-11e4-aace-600308960662"
      assert ledger_entry.payment_id == "7488a646-e31f-11e4-aace-600308960662"
    end

    test "create_ledger_entry/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Core.create_ledger_entry(@invalid_attrs)
    end

    test "update_ledger_entry/2 with valid data updates the ledger_entry" do
      ledger_entry = ledger_entry_fixture()

      update_attrs = %{
        amount: "456.7",
        debit_account_id: "7488a646-e31f-11e4-aace-600308960668",
        credit_account_id: "7488a646-e31f-11e4-aace-600308960668",
        payment_id: "7488a646-e31f-11e4-aace-600308960668"
      }

      assert {:ok, %LedgerEntry{} = ledger_entry} =
               Core.update_ledger_entry(ledger_entry, update_attrs)

      assert ledger_entry.amount == Decimal.new("456.7")
      assert ledger_entry.debit_account_id == "7488a646-e31f-11e4-aace-600308960668"
      assert ledger_entry.credit_account_id == "7488a646-e31f-11e4-aace-600308960668"
      assert ledger_entry.payment_id == "7488a646-e31f-11e4-aace-600308960668"
    end

    test "update_ledger_entry/2 with invalid data returns error changeset" do
      ledger_entry = ledger_entry_fixture()
      assert {:error, %Ecto.Changeset{}} = Core.update_ledger_entry(ledger_entry, @invalid_attrs)
      assert ledger_entry == Core.get_ledger_entry!(ledger_entry.id)
    end

    test "delete_ledger_entry/1 deletes the ledger_entry" do
      ledger_entry = ledger_entry_fixture()
      assert {:ok, %LedgerEntry{}} = Core.delete_ledger_entry(ledger_entry)
      assert_raise Ecto.NoResultsError, fn -> Core.get_ledger_entry!(ledger_entry.id) end
    end

    test "change_ledger_entry/1 returns a ledger_entry changeset" do
      ledger_entry = ledger_entry_fixture()
      assert %Ecto.Changeset{} = Core.change_ledger_entry(ledger_entry)
    end
  end

  describe "merchants" do
    alias Gateway.Core.Merchant

    import Gateway.CoreFixtures

    @invalid_attrs %{name: nil, status: nil, api_key: nil}

    test "list_merchants/0 returns all merchants" do
      merchant = merchant_fixture()
      assert Core.list_merchants() == [merchant]
    end

    test "get_merchant!/1 returns the merchant with given id" do
      merchant = merchant_fixture()
      assert Core.get_merchant!(merchant.id) == merchant
    end

    test "create_merchant/1 with valid data creates a merchant" do
      valid_attrs = %{name: "some name", status: "some status", api_key: "some api_key"}

      assert {:ok, %Merchant{} = merchant} = Core.create_merchant(valid_attrs)
      assert merchant.name == "some name"
      assert merchant.status == "some status"
      assert merchant.api_key == "some api_key"
    end

    test "create_merchant/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Core.create_merchant(@invalid_attrs)
    end

    test "update_merchant/2 with valid data updates the merchant" do
      merchant = merchant_fixture()

      update_attrs = %{
        name: "some updated name",
        status: "some updated status",
        api_key: "some updated api_key"
      }

      assert {:ok, %Merchant{} = merchant} = Core.update_merchant(merchant, update_attrs)
      assert merchant.name == "some updated name"
      assert merchant.status == "some updated status"
      assert merchant.api_key == "some updated api_key"
    end

    test "update_merchant/2 with invalid data returns error changeset" do
      merchant = merchant_fixture()
      assert {:error, %Ecto.Changeset{}} = Core.update_merchant(merchant, @invalid_attrs)
      assert merchant == Core.get_merchant!(merchant.id)
    end

    test "delete_merchant/1 deletes the merchant" do
      merchant = merchant_fixture()
      assert {:ok, %Merchant{}} = Core.delete_merchant(merchant)
      assert_raise Ecto.NoResultsError, fn -> Core.get_merchant!(merchant.id) end
    end

    test "change_merchant/1 returns a merchant changeset" do
      merchant = merchant_fixture()
      assert %Ecto.Changeset{} = Core.change_merchant(merchant)
    end
  end

  describe "merchant_providers" do
    alias Gateway.Core.MerchantProvider

    import Gateway.CoreFixtures

    @invalid_attrs %{enabled: nil, merchant_id: nil, provider_id: nil}

    test "list_merchant_providers/0 returns all merchant_providers" do
      merchant_provider = merchant_provider_fixture()
      assert Core.list_merchant_providers() == [merchant_provider]
    end

    test "get_merchant_provider!/1 returns the merchant_provider with given id" do
      merchant_provider = merchant_provider_fixture()
      assert Core.get_merchant_provider!(merchant_provider.id) == merchant_provider
    end

    test "create_merchant_provider/1 with valid data creates a merchant_provider" do
      valid_attrs = %{
        enabled: true,
        merchant_id: "7488a646-e31f-11e4-aace-600308960662",
        provider_id: "7488a646-e31f-11e4-aace-600308960662"
      }

      assert {:ok, %MerchantProvider{} = merchant_provider} =
               Core.create_merchant_provider(valid_attrs)

      assert merchant_provider.enabled == true
      assert merchant_provider.merchant_id == "7488a646-e31f-11e4-aace-600308960662"
      assert merchant_provider.provider_id == "7488a646-e31f-11e4-aace-600308960662"
    end

    test "create_merchant_provider/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Core.create_merchant_provider(@invalid_attrs)
    end

    test "update_merchant_provider/2 with valid data updates the merchant_provider" do
      merchant_provider = merchant_provider_fixture()

      update_attrs = %{
        enabled: false,
        merchant_id: "7488a646-e31f-11e4-aace-600308960668",
        provider_id: "7488a646-e31f-11e4-aace-600308960668"
      }

      assert {:ok, %MerchantProvider{} = merchant_provider} =
               Core.update_merchant_provider(merchant_provider, update_attrs)

      assert merchant_provider.enabled == false
      assert merchant_provider.merchant_id == "7488a646-e31f-11e4-aace-600308960668"
      assert merchant_provider.provider_id == "7488a646-e31f-11e4-aace-600308960668"
    end

    test "update_merchant_provider/2 with invalid data returns error changeset" do
      merchant_provider = merchant_provider_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Core.update_merchant_provider(merchant_provider, @invalid_attrs)

      assert merchant_provider == Core.get_merchant_provider!(merchant_provider.id)
    end

    test "delete_merchant_provider/1 deletes the merchant_provider" do
      merchant_provider = merchant_provider_fixture()
      assert {:ok, %MerchantProvider{}} = Core.delete_merchant_provider(merchant_provider)

      assert_raise Ecto.NoResultsError, fn ->
        Core.get_merchant_provider!(merchant_provider.id)
      end
    end

    test "change_merchant_provider/1 returns a merchant_provider changeset" do
      merchant_provider = merchant_provider_fixture()
      assert %Ecto.Changeset{} = Core.change_merchant_provider(merchant_provider)
    end
  end

  describe "merchant_fee_configs" do
    alias Gateway.Core.FeeConfig

    import Gateway.CoreFixtures

    @invalid_attrs %{
      active: nil,
      merchant_id: nil,
      provider_id: nil,
      collection_percentage: nil,
      disbursement_percentage: nil,
      flat_fee: nil,
      tax_percentage: nil
    }

    test "list_merchant_fee_configs/0 returns all merchant_fee_configs" do
      fee_config = fee_config_fixture()
      assert Core.list_merchant_fee_configs() == [fee_config]
    end

    test "get_fee_config!/1 returns the fee_config with given id" do
      fee_config = fee_config_fixture()
      assert Core.get_fee_config!(fee_config.id) == fee_config
    end

    test "create_fee_config/1 with valid data creates a fee_config" do
      valid_attrs = %{
        active: true,
        merchant_id: "7488a646-e31f-11e4-aace-600308960662",
        provider_id: "7488a646-e31f-11e4-aace-600308960662",
        collection_percentage: "120.5",
        disbursement_percentage: "120.5",
        flat_fee: "120.5",
        tax_percentage: "120.5"
      }

      assert {:ok, %FeeConfig{} = fee_config} = Core.create_fee_config(valid_attrs)
      assert fee_config.active == true
      assert fee_config.merchant_id == "7488a646-e31f-11e4-aace-600308960662"
      assert fee_config.provider_id == "7488a646-e31f-11e4-aace-600308960662"
      assert fee_config.collection_percentage == Decimal.new("120.5")
      assert fee_config.disbursement_percentage == Decimal.new("120.5")
      assert fee_config.flat_fee == Decimal.new("120.5")
      assert fee_config.tax_percentage == Decimal.new("120.5")
    end

    test "create_fee_config/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Core.create_fee_config(@invalid_attrs)
    end

    test "update_fee_config/2 with valid data updates the fee_config" do
      fee_config = fee_config_fixture()

      update_attrs = %{
        active: false,
        merchant_id: "7488a646-e31f-11e4-aace-600308960668",
        provider_id: "7488a646-e31f-11e4-aace-600308960668",
        collection_percentage: "456.7",
        disbursement_percentage: "456.7",
        flat_fee: "456.7",
        tax_percentage: "456.7"
      }

      assert {:ok, %FeeConfig{} = fee_config} = Core.update_fee_config(fee_config, update_attrs)
      assert fee_config.active == false
      assert fee_config.merchant_id == "7488a646-e31f-11e4-aace-600308960668"
      assert fee_config.provider_id == "7488a646-e31f-11e4-aace-600308960668"
      assert fee_config.collection_percentage == Decimal.new("456.7")
      assert fee_config.disbursement_percentage == Decimal.new("456.7")
      assert fee_config.flat_fee == Decimal.new("456.7")
      assert fee_config.tax_percentage == Decimal.new("456.7")
    end

    test "update_fee_config/2 with invalid data returns error changeset" do
      fee_config = fee_config_fixture()
      assert {:error, %Ecto.Changeset{}} = Core.update_fee_config(fee_config, @invalid_attrs)
      assert fee_config == Core.get_fee_config!(fee_config.id)
    end

    test "delete_fee_config/1 deletes the fee_config" do
      fee_config = fee_config_fixture()
      assert {:ok, %FeeConfig{}} = Core.delete_fee_config(fee_config)
      assert_raise Ecto.NoResultsError, fn -> Core.get_fee_config!(fee_config.id) end
    end

    test "change_fee_config/1 returns a fee_config changeset" do
      fee_config = fee_config_fixture()
      assert %Ecto.Changeset{} = Core.change_fee_config(fee_config)
    end
  end

  describe "providers" do
    alias Gateway.Core.Provider

    import Gateway.CoreFixtures

    @invalid_attrs %{active: nil, name: nil, type: nil}

    test "list_providers/0 returns all providers" do
      provider = provider_fixture()
      assert Core.list_providers() == [provider]
    end

    test "get_provider!/1 returns the provider with given id" do
      provider = provider_fixture()
      assert Core.get_provider!(provider.id) == provider
    end

    test "create_provider/1 with valid data creates a provider" do
      valid_attrs = %{active: true, name: "some name", type: "some type"}

      assert {:ok, %Provider{} = provider} = Core.create_provider(valid_attrs)
      assert provider.active == true
      assert provider.name == "some name"
      assert provider.type == "some type"
    end

    test "create_provider/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Core.create_provider(@invalid_attrs)
    end

    test "update_provider/2 with valid data updates the provider" do
      provider = provider_fixture()
      update_attrs = %{active: false, name: "some updated name", type: "some updated type"}

      assert {:ok, %Provider{} = provider} = Core.update_provider(provider, update_attrs)
      assert provider.active == false
      assert provider.name == "some updated name"
      assert provider.type == "some updated type"
    end

    test "update_provider/2 with invalid data returns error changeset" do
      provider = provider_fixture()
      assert {:error, %Ecto.Changeset{}} = Core.update_provider(provider, @invalid_attrs)
      assert provider == Core.get_provider!(provider.id)
    end

    test "delete_provider/1 deletes the provider" do
      provider = provider_fixture()
      assert {:ok, %Provider{}} = Core.delete_provider(provider)
      assert_raise Ecto.NoResultsError, fn -> Core.get_provider!(provider.id) end
    end

    test "change_provider/1 returns a provider changeset" do
      provider = provider_fixture()
      assert %Ecto.Changeset{} = Core.change_provider(provider)
    end
  end

  describe "provider_credentials" do
    alias Gateway.Core.ProviderCredential

    import Gateway.CoreFixtures

    @invalid_attrs %{provider_id: nil, config_json: nil}

    test "list_provider_credentials/0 returns all provider_credentials" do
      provider_credential = provider_credential_fixture()
      assert Core.list_provider_credentials() == [provider_credential]
    end

    test "get_provider_credential!/1 returns the provider_credential with given id" do
      provider_credential = provider_credential_fixture()
      assert Core.get_provider_credential!(provider_credential.id) == provider_credential
    end

    test "create_provider_credential/1 with valid data creates a provider_credential" do
      valid_attrs = %{provider_id: "7488a646-e31f-11e4-aace-600308960662", config_json: %{}}

      assert {:ok, %ProviderCredential{} = provider_credential} =
               Core.create_provider_credential(valid_attrs)

      assert provider_credential.provider_id == "7488a646-e31f-11e4-aace-600308960662"
      assert provider_credential.config_json == %{}
    end

    test "create_provider_credential/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Core.create_provider_credential(@invalid_attrs)
    end

    test "update_provider_credential/2 with valid data updates the provider_credential" do
      provider_credential = provider_credential_fixture()
      update_attrs = %{provider_id: "7488a646-e31f-11e4-aace-600308960668", config_json: %{}}

      assert {:ok, %ProviderCredential{} = provider_credential} =
               Core.update_provider_credential(provider_credential, update_attrs)

      assert provider_credential.provider_id == "7488a646-e31f-11e4-aace-600308960668"
      assert provider_credential.config_json == %{}
    end

    test "update_provider_credential/2 with invalid data returns error changeset" do
      provider_credential = provider_credential_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Core.update_provider_credential(provider_credential, @invalid_attrs)

      assert provider_credential == Core.get_provider_credential!(provider_credential.id)
    end

    test "delete_provider_credential/1 deletes the provider_credential" do
      provider_credential = provider_credential_fixture()
      assert {:ok, %ProviderCredential{}} = Core.delete_provider_credential(provider_credential)

      assert_raise Ecto.NoResultsError, fn ->
        Core.get_provider_credential!(provider_credential.id)
      end
    end

    test "change_provider_credential/1 returns a provider_credential changeset" do
      provider_credential = provider_credential_fixture()
      assert %Ecto.Changeset{} = Core.change_provider_credential(provider_credential)
    end
  end

  describe "users" do
    alias Gateway.Core.User

    import Gateway.CoreFixtures

    @invalid_attrs %{email: nil, password_hash: nil, merchant_id: nil, role_id: nil}

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Core.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Core.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs = %{
        email: "some email",
        password_hash: "some password_hash",
        merchant_id: "7488a646-e31f-11e4-aace-600308960662",
        role_id: "7488a646-e31f-11e4-aace-600308960662"
      }

      assert {:ok, %User{} = user} = Core.create_user(valid_attrs)
      assert user.email == "some email"
      assert user.password_hash == "some password_hash"
      assert user.merchant_id == "7488a646-e31f-11e4-aace-600308960662"
      assert user.role_id == "7488a646-e31f-11e4-aace-600308960662"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Core.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()

      update_attrs = %{
        email: "some updated email",
        password_hash: "some updated password_hash",
        merchant_id: "7488a646-e31f-11e4-aace-600308960668",
        role_id: "7488a646-e31f-11e4-aace-600308960668"
      }

      assert {:ok, %User{} = user} = Core.update_user(user, update_attrs)
      assert user.email == "some updated email"
      assert user.password_hash == "some updated password_hash"
      assert user.merchant_id == "7488a646-e31f-11e4-aace-600308960668"
      assert user.role_id == "7488a646-e31f-11e4-aace-600308960668"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Core.update_user(user, @invalid_attrs)
      assert user == Core.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Core.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Core.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Core.change_user(user)
    end
  end

  describe "permissions" do
    alias Gateway.Core.Permission

    import Gateway.CoreFixtures

    @invalid_attrs %{name: nil}

    test "list_permissions/0 returns all permissions" do
      permission = permission_fixture()
      assert Core.list_permissions() == [permission]
    end

    test "get_permission!/1 returns the permission with given id" do
      permission = permission_fixture()
      assert Core.get_permission!(permission.id) == permission
    end

    test "create_permission/1 with valid data creates a permission" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Permission{} = permission} = Core.create_permission(valid_attrs)
      assert permission.name == "some name"
    end

    test "create_permission/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Core.create_permission(@invalid_attrs)
    end

    test "update_permission/2 with valid data updates the permission" do
      permission = permission_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Permission{} = permission} = Core.update_permission(permission, update_attrs)
      assert permission.name == "some updated name"
    end

    test "update_permission/2 with invalid data returns error changeset" do
      permission = permission_fixture()
      assert {:error, %Ecto.Changeset{}} = Core.update_permission(permission, @invalid_attrs)
      assert permission == Core.get_permission!(permission.id)
    end

    test "delete_permission/1 deletes the permission" do
      permission = permission_fixture()
      assert {:ok, %Permission{}} = Core.delete_permission(permission)
      assert_raise Ecto.NoResultsError, fn -> Core.get_permission!(permission.id) end
    end

    test "change_permission/1 returns a permission changeset" do
      permission = permission_fixture()
      assert %Ecto.Changeset{} = Core.change_permission(permission)
    end
  end

  describe "role_permissions" do
    alias Gateway.Core.RolePermission

    import Gateway.CoreFixtures

    @invalid_attrs %{role_id: nil, permission_id: nil}

    test "list_role_permissions/0 returns all role_permissions" do
      role_permission = role_permission_fixture()
      assert Core.list_role_permissions() == [role_permission]
    end

    test "get_role_permission!/1 returns the role_permission with given id" do
      role_permission = role_permission_fixture()
      assert Core.get_role_permission!(role_permission.id) == role_permission
    end

    test "create_role_permission/1 with valid data creates a role_permission" do
      valid_attrs = %{
        role_id: "7488a646-e31f-11e4-aace-600308960662",
        permission_id: "7488a646-e31f-11e4-aace-600308960662"
      }

      assert {:ok, %RolePermission{} = role_permission} = Core.create_role_permission(valid_attrs)
      assert role_permission.role_id == "7488a646-e31f-11e4-aace-600308960662"
      assert role_permission.permission_id == "7488a646-e31f-11e4-aace-600308960662"
    end

    test "create_role_permission/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Core.create_role_permission(@invalid_attrs)
    end

    test "update_role_permission/2 with valid data updates the role_permission" do
      role_permission = role_permission_fixture()

      update_attrs = %{
        role_id: "7488a646-e31f-11e4-aace-600308960668",
        permission_id: "7488a646-e31f-11e4-aace-600308960668"
      }

      assert {:ok, %RolePermission{} = role_permission} =
               Core.update_role_permission(role_permission, update_attrs)

      assert role_permission.role_id == "7488a646-e31f-11e4-aace-600308960668"
      assert role_permission.permission_id == "7488a646-e31f-11e4-aace-600308960668"
    end

    test "update_role_permission/2 with invalid data returns error changeset" do
      role_permission = role_permission_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Core.update_role_permission(role_permission, @invalid_attrs)

      assert role_permission == Core.get_role_permission!(role_permission.id)
    end

    test "delete_role_permission/1 deletes the role_permission" do
      role_permission = role_permission_fixture()
      assert {:ok, %RolePermission{}} = Core.delete_role_permission(role_permission)
      assert_raise Ecto.NoResultsError, fn -> Core.get_role_permission!(role_permission.id) end
    end

    test "change_role_permission/1 returns a role_permission changeset" do
      role_permission = role_permission_fixture()
      assert %Ecto.Changeset{} = Core.change_role_permission(role_permission)
    end
  end
end
