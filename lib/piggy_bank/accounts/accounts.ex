defmodule PiggyBank.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias PiggyBank.Repo

  alias PiggyBank.Accounts.Account

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
  def create_account(attrs \\ %{}) do
    # raise "TODO"
    # Leverage Repo transactions
    # Create account + insert telemetry data

    # Repo.transaction(fn ->
    #   with {:ok, issue} <- Issue.changeset(%Issue{}, issue_params) |> Repo.insert(),
    #        {:ok, _store_issue_from_type} <-
    #          store_issue_from_type(issue.type, issue_type_params, issue.id),
    #         {:ok, telemetry} <- AppTelemetry.create_and_insert_telemetry(issue) do
    #     {:ok, issue}
    #   else
    #     error ->
    #       Logger.error("Transaction failed: #{inspect(error)}")
    #       Repo.rollback(error)
    #   end
    # end)
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
  def change_account(%Account{} = account, _attrs \\ %{}) do
    raise "TODO"
  end
end
