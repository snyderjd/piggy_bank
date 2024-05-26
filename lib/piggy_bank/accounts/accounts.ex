defmodule PiggyBank.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias Ecto.Multi
  alias PiggyBank.Repo
  alias PiggyBank.Accounts.Account
  alias PiggyBank.AppTelemetryContext.AppTelemetry
  require Logger

  @spec list_accounts() :: [Account.t()]
  @doc """
  Returns the list of accounts.
  ## Examples
      iex> list_accounts()
      [%Account{}, ...]
  """
  def list_accounts do
    Account
    |> preload([:account_type, :user])
    |> Repo.all()
  end

  @spec get_account!(integer()) :: Account.t()
  @doc """
  Gets a single account. Raises if the Account does not exist.
  ## Examples
      iex> get_account!(123)
      %Account{}
  """
  def get_account!(id) do
    Account
    |> preload([:account_type, :user, :transactions])
    |> Repo.get!(id)
  end

  @doc """
  Creates a account.
  ## Examples
      iex> create_account(%{field: value})
      {:ok, %Account{}}
      iex> create_account(%{field: bad_value})
      {:error, ...}
  """
  @spec create_account(map()) :: {:ok, Account.t()}
  def create_account(attrs \\ %{}) do
    # Create account + insert telemetry data
    Multi.new()
    |> Multi.insert(:account, insert_account_changeset(attrs))
    |> Multi.insert(:app_telemetry, fn %{account: account} ->
      telemetry_for_create_account_changeset(account)
    end)
    |> Repo.transaction()
  end

  defp insert_account_changeset(attrs) do
    Account.changeset(%Account{}, attrs)
  end

  defp telemetry_for_create_account_changeset(account) do
    # Telemetry notes:
    #   event_name: make machine-readable: Ex: action_resource == create_account
    #   description: Human readable
    #   metadata: current_user info, any info that is meaningful to this specific event
    #   - tenant_id for multi-tenant app
    #   Put specific things in meta data to keep from adding nullable associations

    telemetry_params = %{
      event_name: "create_account",
      description: "Create Account #{account.name}",
      metadata: %{},
      date: DateTime.utc_now(),
      account: account,
      user: nil
    }

    AppTelemetry.changeset(%AppTelemetry{}, telemetry_params)
  end

  @doc """
  Updates a account.
  ## Examples
      iex> update_account(account, %{field: new_value})
      {:ok, %Account{}}
      iex> update_account(account, %{field: bad_value})
      {:error, ...}
  """
  def update_account(%Account{} = _account, _attrs) do
    raise "TODO"
  end

  @doc """
  Deletes a Account.
  ## Examples
      iex> delete_account(account)
      {:ok, %Account{}}
      iex> delete_account(account)
      {:error, ...}
  """
  def delete_account(%Account{} = _account) do
    raise "TODO"
  end

  @doc """
  Returns a data structure for tracking account changes.
  ## Examples
      iex> change_account(account)
      %Todo{...}
  """
  def change_account(%Account{} = account, attrs \\ %{}) do
    Account.changeset(account, attrs)
  end
end
