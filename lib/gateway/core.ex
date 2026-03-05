defmodule Gateway.Core do
  @moduledoc """
  The Core context.
  """

  import Ecto.Query, warn: false
  alias Gateway.Repo

  alias Gateway.Core.Payments

  @doc """
  Returns the list of payment.

  ## Examples

      iex> list_payment()
      [%Payments{}, ...]

  """
  def list_payment do
    Repo.all(Payments)
  end

  @doc """
  Gets a single payments.

  Raises `Ecto.NoResultsError` if the Payments does not exist.

  ## Examples

      iex> get_payments!(123)
      %Payments{}

      iex> get_payments!(456)
      ** (Ecto.NoResultsError)

  """
  def get_payments!(id), do: Repo.get!(Payments, id)

  @doc """
  Creates a payments.

  ## Examples

      iex> create_payments(%{field: value})
      {:ok, %Payments{}}

      iex> create_payments(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_payments(attrs) do
    %Payments{}
    |> Payments.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a payments.

  ## Examples

      iex> update_payments(payments, %{field: new_value})
      {:ok, %Payments{}}

      iex> update_payments(payments, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_payments(%Payments{} = payments, attrs) do
    payments
    |> Payments.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a payments.

  ## Examples

      iex> delete_payments(payments)
      {:ok, %Payments{}}

      iex> delete_payments(payments)
      {:error, %Ecto.Changeset{}}

  """
  def delete_payments(%Payments{} = payments) do
    Repo.delete(payments)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking payments changes.

  ## Examples

      iex> change_payments(payments)
      %Ecto.Changeset{data: %Payments{}}

  """
  def change_payments(%Payments{} = payments, attrs \\ %{}) do
    Payments.changeset(payments, attrs)
  end

  alias Gateway.Core.LedgerAccount

  @doc """
  Returns the list of ledger_accounts.

  ## Examples

      iex> list_ledger_accounts()
      [%LedgerAccount{}, ...]

  """
  def list_ledger_accounts do
    Repo.all(LedgerAccount)
  end

  @doc """
  Gets a single ledger_account.

  Raises `Ecto.NoResultsError` if the Ledger account does not exist.

  ## Examples

      iex> get_ledger_account!(123)
      %LedgerAccount{}

      iex> get_ledger_account!(456)
      ** (Ecto.NoResultsError)

  """
  def get_ledger_account!(id), do: Repo.get!(LedgerAccount, id)

  @doc """
  Creates a ledger_account.

  ## Examples

      iex> create_ledger_account(%{field: value})
      {:ok, %LedgerAccount{}}

      iex> create_ledger_account(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_ledger_account(attrs) do
    %LedgerAccount{}
    |> LedgerAccount.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a ledger_account.

  ## Examples

      iex> update_ledger_account(ledger_account, %{field: new_value})
      {:ok, %LedgerAccount{}}

      iex> update_ledger_account(ledger_account, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_ledger_account(%LedgerAccount{} = ledger_account, attrs) do
    ledger_account
    |> LedgerAccount.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a ledger_account.

  ## Examples

      iex> delete_ledger_account(ledger_account)
      {:ok, %LedgerAccount{}}

      iex> delete_ledger_account(ledger_account)
      {:error, %Ecto.Changeset{}}

  """
  def delete_ledger_account(%LedgerAccount{} = ledger_account) do
    Repo.delete(ledger_account)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking ledger_account changes.

  ## Examples

      iex> change_ledger_account(ledger_account)
      %Ecto.Changeset{data: %LedgerAccount{}}

  """
  def change_ledger_account(%LedgerAccount{} = ledger_account, attrs \\ %{}) do
    LedgerAccount.changeset(ledger_account, attrs)
  end

  alias Gateway.Core.LedgerEntry

  @doc """
  Returns the list of ledger_entries.

  ## Examples

      iex> list_ledger_entries()
      [%LedgerEntry{}, ...]

  """
  def list_ledger_entries do
    Repo.all(LedgerEntry)
  end

  @doc """
  Gets a single ledger_entry.

  Raises `Ecto.NoResultsError` if the Ledger entry does not exist.

  ## Examples

      iex> get_ledger_entry!(123)
      %LedgerEntry{}

      iex> get_ledger_entry!(456)
      ** (Ecto.NoResultsError)

  """
  def get_ledger_entry!(id), do: Repo.get!(LedgerEntry, id)

  @doc """
  Creates a ledger_entry.

  ## Examples

      iex> create_ledger_entry(%{field: value})
      {:ok, %LedgerEntry{}}

      iex> create_ledger_entry(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_ledger_entry(attrs) do
    %LedgerEntry{}
    |> LedgerEntry.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a ledger_entry.

  ## Examples

      iex> update_ledger_entry(ledger_entry, %{field: new_value})
      {:ok, %LedgerEntry{}}

      iex> update_ledger_entry(ledger_entry, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_ledger_entry(%LedgerEntry{} = ledger_entry, attrs) do
    ledger_entry
    |> LedgerEntry.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a ledger_entry.

  ## Examples

      iex> delete_ledger_entry(ledger_entry)
      {:ok, %LedgerEntry{}}

      iex> delete_ledger_entry(ledger_entry)
      {:error, %Ecto.Changeset{}}

  """
  def delete_ledger_entry(%LedgerEntry{} = ledger_entry) do
    Repo.delete(ledger_entry)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking ledger_entry changes.

  ## Examples

      iex> change_ledger_entry(ledger_entry)
      %Ecto.Changeset{data: %LedgerEntry{}}

  """
  def change_ledger_entry(%LedgerEntry{} = ledger_entry, attrs \\ %{}) do
    LedgerEntry.changeset(ledger_entry, attrs)
  end

  alias Gateway.Core.Merchant

  @doc """
  Returns the list of merchants.

  ## Examples

      iex> list_merchants()
      [%Merchant{}, ...]

  """
  def list_merchants do
    Repo.all(Merchant)
  end

  @doc """
  Gets a single merchant.

  Raises `Ecto.NoResultsError` if the Merchant does not exist.

  ## Examples

      iex> get_merchant!(123)
      %Merchant{}

      iex> get_merchant!(456)
      ** (Ecto.NoResultsError)

  """
  def get_merchant!(id), do: Repo.get!(Merchant, id)

  @doc """
  Creates a merchant.

  ## Examples

      iex> create_merchant(%{field: value})
      {:ok, %Merchant{}}

      iex> create_merchant(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_merchant(attrs) do
    %Merchant{}
    |> Merchant.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a merchant.

  ## Examples

      iex> update_merchant(merchant, %{field: new_value})
      {:ok, %Merchant{}}

      iex> update_merchant(merchant, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_merchant(%Merchant{} = merchant, attrs) do
    merchant
    |> Merchant.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a merchant.

  ## Examples

      iex> delete_merchant(merchant)
      {:ok, %Merchant{}}

      iex> delete_merchant(merchant)
      {:error, %Ecto.Changeset{}}

  """
  def delete_merchant(%Merchant{} = merchant) do
    Repo.delete(merchant)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking merchant changes.

  ## Examples

      iex> change_merchant(merchant)
      %Ecto.Changeset{data: %Merchant{}}

  """
  def change_merchant(%Merchant{} = merchant, attrs \\ %{}) do
    Merchant.changeset(merchant, attrs)
  end

  alias Gateway.Core.MerchantProvider

  @doc """
  Returns the list of merchant_providers.

  ## Examples

      iex> list_merchant_providers()
      [%MerchantProvider{}, ...]

  """
  def list_merchant_providers do
    Repo.all(MerchantProvider)
  end

  @doc """
  Gets a single merchant_provider.

  Raises `Ecto.NoResultsError` if the Merchant provider does not exist.

  ## Examples

      iex> get_merchant_provider!(123)
      %MerchantProvider{}

      iex> get_merchant_provider!(456)
      ** (Ecto.NoResultsError)

  """
  def get_merchant_provider!(id), do: Repo.get!(MerchantProvider, id)

  @doc """
  Creates a merchant_provider.

  ## Examples

      iex> create_merchant_provider(%{field: value})
      {:ok, %MerchantProvider{}}

      iex> create_merchant_provider(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_merchant_provider(attrs) do
    %MerchantProvider{}
    |> MerchantProvider.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a merchant_provider.

  ## Examples

      iex> update_merchant_provider(merchant_provider, %{field: new_value})
      {:ok, %MerchantProvider{}}

      iex> update_merchant_provider(merchant_provider, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_merchant_provider(%MerchantProvider{} = merchant_provider, attrs) do
    merchant_provider
    |> MerchantProvider.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a merchant_provider.

  ## Examples

      iex> delete_merchant_provider(merchant_provider)
      {:ok, %MerchantProvider{}}

      iex> delete_merchant_provider(merchant_provider)
      {:error, %Ecto.Changeset{}}

  """
  def delete_merchant_provider(%MerchantProvider{} = merchant_provider) do
    Repo.delete(merchant_provider)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking merchant_provider changes.

  ## Examples

      iex> change_merchant_provider(merchant_provider)
      %Ecto.Changeset{data: %MerchantProvider{}}

  """
  def change_merchant_provider(%MerchantProvider{} = merchant_provider, attrs \\ %{}) do
    MerchantProvider.changeset(merchant_provider, attrs)
  end

  alias Gateway.Core.FeeConfig

  @doc """
  Returns the list of merchant_fee_configs.

  ## Examples

      iex> list_merchant_fee_configs()
      [%FeeConfig{}, ...]

  """
  def list_merchant_fee_configs do
    Repo.all(FeeConfig)
  end

  @doc """
  Gets a single fee_config.

  Raises `Ecto.NoResultsError` if the Fee config does not exist.

  ## Examples

      iex> get_fee_config!(123)
      %FeeConfig{}

      iex> get_fee_config!(456)
      ** (Ecto.NoResultsError)

  """
  def get_fee_config!(id), do: Repo.get!(FeeConfig, id)

  @doc """
  Creates a fee_config.

  ## Examples

      iex> create_fee_config(%{field: value})
      {:ok, %FeeConfig{}}

      iex> create_fee_config(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_fee_config(attrs) do
    %FeeConfig{}
    |> FeeConfig.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a fee_config.

  ## Examples

      iex> update_fee_config(fee_config, %{field: new_value})
      {:ok, %FeeConfig{}}

      iex> update_fee_config(fee_config, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_fee_config(%FeeConfig{} = fee_config, attrs) do
    fee_config
    |> FeeConfig.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a fee_config.

  ## Examples

      iex> delete_fee_config(fee_config)
      {:ok, %FeeConfig{}}

      iex> delete_fee_config(fee_config)
      {:error, %Ecto.Changeset{}}

  """
  def delete_fee_config(%FeeConfig{} = fee_config) do
    Repo.delete(fee_config)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking fee_config changes.

  ## Examples

      iex> change_fee_config(fee_config)
      %Ecto.Changeset{data: %FeeConfig{}}

  """
  def change_fee_config(%FeeConfig{} = fee_config, attrs \\ %{}) do
    FeeConfig.changeset(fee_config, attrs)
  end

  alias Gateway.Core.Provider

  @doc """
  Returns the list of providers.

  ## Examples

      iex> list_providers()
      [%Provider{}, ...]

  """
  def list_providers do
    Repo.all(Provider)
  end

  @doc """
  Gets a single provider.

  Raises `Ecto.NoResultsError` if the Provider does not exist.

  ## Examples

      iex> get_provider!(123)
      %Provider{}

      iex> get_provider!(456)
      ** (Ecto.NoResultsError)

  """
  def get_provider!(id), do: Repo.get!(Provider, id)

  @doc """
  Creates a provider.

  ## Examples

      iex> create_provider(%{field: value})
      {:ok, %Provider{}}

      iex> create_provider(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_provider(attrs) do
    %Provider{}
    |> Provider.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a provider.

  ## Examples

      iex> update_provider(provider, %{field: new_value})
      {:ok, %Provider{}}

      iex> update_provider(provider, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_provider(%Provider{} = provider, attrs) do
    provider
    |> Provider.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a provider.

  ## Examples

      iex> delete_provider(provider)
      {:ok, %Provider{}}

      iex> delete_provider(provider)
      {:error, %Ecto.Changeset{}}

  """
  def delete_provider(%Provider{} = provider) do
    Repo.delete(provider)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking provider changes.

  ## Examples

      iex> change_provider(provider)
      %Ecto.Changeset{data: %Provider{}}

  """
  def change_provider(%Provider{} = provider, attrs \\ %{}) do
    Provider.changeset(provider, attrs)
  end

  alias Gateway.Core.ProviderCredential

  @doc """
  Returns the list of provider_credentials.

  ## Examples

      iex> list_provider_credentials()
      [%ProviderCredential{}, ...]

  """
  def list_provider_credentials do
    Repo.all(ProviderCredential)
  end

  @doc """
  Gets a single provider_credential.

  Raises `Ecto.NoResultsError` if the Provider credential does not exist.

  ## Examples

      iex> get_provider_credential!(123)
      %ProviderCredential{}

      iex> get_provider_credential!(456)
      ** (Ecto.NoResultsError)

  """
  def get_provider_credential!(id), do: Repo.get!(ProviderCredential, id)

  @doc """
  Creates a provider_credential.

  ## Examples

      iex> create_provider_credential(%{field: value})
      {:ok, %ProviderCredential{}}

      iex> create_provider_credential(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_provider_credential(attrs) do
    %ProviderCredential{}
    |> ProviderCredential.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a provider_credential.

  ## Examples

      iex> update_provider_credential(provider_credential, %{field: new_value})
      {:ok, %ProviderCredential{}}

      iex> update_provider_credential(provider_credential, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_provider_credential(%ProviderCredential{} = provider_credential, attrs) do
    provider_credential
    |> ProviderCredential.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a provider_credential.

  ## Examples

      iex> delete_provider_credential(provider_credential)
      {:ok, %ProviderCredential{}}

      iex> delete_provider_credential(provider_credential)
      {:error, %Ecto.Changeset{}}

  """
  def delete_provider_credential(%ProviderCredential{} = provider_credential) do
    Repo.delete(provider_credential)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking provider_credential changes.

  ## Examples

      iex> change_provider_credential(provider_credential)
      %Ecto.Changeset{data: %ProviderCredential{}}

  """
  def change_provider_credential(%ProviderCredential{} = provider_credential, attrs \\ %{}) do
    ProviderCredential.changeset(provider_credential, attrs)
  end

  alias Gateway.Core.User

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{data: %User{}}

  """
  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end

  alias Gateway.Core.Permission

  @doc """
  Returns the list of permissions.

  ## Examples

      iex> list_permissions()
      [%Permission{}, ...]

  """
  def list_permissions do
    Repo.all(Permission)
  end

  @doc """
  Gets a single permission.

  Raises `Ecto.NoResultsError` if the Permission does not exist.

  ## Examples

      iex> get_permission!(123)
      %Permission{}

      iex> get_permission!(456)
      ** (Ecto.NoResultsError)

  """
  def get_permission!(id), do: Repo.get!(Permission, id)

  @doc """
  Creates a permission.

  ## Examples

      iex> create_permission(%{field: value})
      {:ok, %Permission{}}

      iex> create_permission(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_permission(attrs) do
    %Permission{}
    |> Permission.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a permission.

  ## Examples

      iex> update_permission(permission, %{field: new_value})
      {:ok, %Permission{}}

      iex> update_permission(permission, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_permission(%Permission{} = permission, attrs) do
    permission
    |> Permission.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a permission.

  ## Examples

      iex> delete_permission(permission)
      {:ok, %Permission{}}

      iex> delete_permission(permission)
      {:error, %Ecto.Changeset{}}

  """
  def delete_permission(%Permission{} = permission) do
    Repo.delete(permission)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking permission changes.

  ## Examples

      iex> change_permission(permission)
      %Ecto.Changeset{data: %Permission{}}

  """
  def change_permission(%Permission{} = permission, attrs \\ %{}) do
    Permission.changeset(permission, attrs)
  end

  alias Gateway.Core.RolePermission

  @doc """
  Returns the list of role_permissions.

  ## Examples

      iex> list_role_permissions()
      [%RolePermission{}, ...]

  """
  def list_role_permissions do
    Repo.all(RolePermission)
  end

  @doc """
  Gets a single role_permission.

  Raises `Ecto.NoResultsError` if the Role permission does not exist.

  ## Examples

      iex> get_role_permission!(123)
      %RolePermission{}

      iex> get_role_permission!(456)
      ** (Ecto.NoResultsError)

  """
  def get_role_permission!(id), do: Repo.get!(RolePermission, id)

  @doc """
  Creates a role_permission.

  ## Examples

      iex> create_role_permission(%{field: value})
      {:ok, %RolePermission{}}

      iex> create_role_permission(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_role_permission(attrs) do
    %RolePermission{}
    |> RolePermission.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a role_permission.

  ## Examples

      iex> update_role_permission(role_permission, %{field: new_value})
      {:ok, %RolePermission{}}

      iex> update_role_permission(role_permission, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_role_permission(%RolePermission{} = role_permission, attrs) do
    role_permission
    |> RolePermission.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a role_permission.

  ## Examples

      iex> delete_role_permission(role_permission)
      {:ok, %RolePermission{}}

      iex> delete_role_permission(role_permission)
      {:error, %Ecto.Changeset{}}

  """
  def delete_role_permission(%RolePermission{} = role_permission) do
    Repo.delete(role_permission)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking role_permission changes.

  ## Examples

      iex> change_role_permission(role_permission)
      %Ecto.Changeset{data: %RolePermission{}}

  """
  def change_role_permission(%RolePermission{} = role_permission, attrs \\ %{}) do
    RolePermission.changeset(role_permission, attrs)
  end
end
