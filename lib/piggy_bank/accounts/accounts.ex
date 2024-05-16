defmodule PiggyBank.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias PiggyBank.Repo
  alias PiggyBank.Accounts.Account
  alias PiggyBank.AppTelemetryContext.AppTelemetry
  alias PiggyBank.AppTelemetryContext
  require Logger

  @doc """
  Returns the list of accounts.

  ## Examples

      iex> list_accounts()
      [%Account{}, ...]

  """
  def list_accounts do
    Account
    |> preload([:account_type])
    |> Repo.all()
  end

  @doc """
  Gets a single account.

  Raises if the Account does not exist.

  ## Examples

      iex> get_account!(123)
      %Account{}

  """
  def get_account!(id), do: raise("TODO")

  @doc """
  Creates a account.

  ## Examples

      iex> create_account(%{field: value})
      {:ok, %Account{}}

      iex> create_account(%{field: bad_value})
      {:error, ...}

  """
  @spec create_account(map()) :: {:ok, Account.t()} | {:error, _error}
  def create_account(attrs \\ %{}) do
    # Create account + insert telemetry data
    Repo.transaction(fn ->
      with {:ok, account} <- insert_account(attrs),
           {:ok, _telemetry} <- insert_telemetry_for_create_account(account) do
        {:ok, account}
      else
        error ->
          Logger.error("Transaction failed: #{inspect(error)}")
          Repo.rollback(error)
      end
    end)
  end

  defp insert_account(attrs) do
    %Account{}
    |> Account.changeset(attrs)
    |> Repo.insert()
  end

  defp insert_telemetry_for_create_account(account) do
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

    %AppTelemetry{}
    |> AppTelemetry.changeset(telemetry_params)
    |> Repo.insert()
  end

  @doc """
  Updates a account.

  ## Examples

      iex> update_account(account, %{field: new_value})
      {:ok, %Account{}}

      iex> update_account(account, %{field: bad_value})
      {:error, ...}

  """
  def update_account(%Account{} = account, attrs) do
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
  def delete_account(%Account{} = account) do
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
