defmodule PiggyBank.LedgerEntries do
  @moduledoc """
  The LedgerEntries context.
  """

  import Ecto.Query, warn: false
  alias Ecto.Multi
  alias PiggyBank.Repo
  alias PiggyBank.LedgerEntries.LedgerEntry
  alias PiggyBank.Transactions.Transaction

  @spec list_ledger_entries :: [LedgerEntry.t()]
  @doc """
  Returns the list of ledger_entries.

  ## Examples

      iex> list_ledger_entries()
      [%LedgerEntry{}, ...]

  """
  def list_ledger_entries do
    LedgerEntry
    |> preload([:transactions])
    |> Repo.all()
  end

  @spec get_ledger_entry!(integer()) :: LedgerEntry.t()
  @doc """
  Gets a single ledger_entry. Raises if the Ledger entry does not exist.
  ## Examples
      iex> get_ledger_entry!(123)
      %LedgerEntry{}
  """
  def get_ledger_entry!(id), do: Repo.get!(LedgerEntry, id)

  @doc """
  Creates a ledger_entry.
  ## Examples
      iex> create_ledger_entry(%{field: value})
      {:ok, %LedgerEntry{}}
      iex> create_ledger_entry(%{field: bad_value})
      {:error, ...}
  """
  def create_ledger_entry(attrs \\ %{}) do
    # Need to do all of the following to create a valid ledger_entry
    #   - Insert the ledger_entry
    #   - Insert the relevant transactions
    #   - Validate the transactions/ledger_entry (debits == credits, assets == liabilities, etc.)
    #   - Insert telemetry
    #   - Commit the transaction
    Multi.new()
    |> Multi.insert(:ledger_entry, LedgerEntry.changeset(%LedgerEntry{}, attrs.ledger_entry))
    |> Multi.run(:transactions, fn repo, %{ledger_entry: ledger_entry} ->
      transactions =
        attrs.transactions
        |> Enum.map(fn t ->
          params = Map.put(t, :ledger_entry, ledger_entry)

          %Transaction{}
          |> Transaction.changeset(params)
          |> repo.insert!()
        end)

      {:ok, transactions}
    end)
    |> Repo.transaction()
  end

  # @spec create_account(map()) :: {:ok, Account.t()}
  # def create_account(attrs \\ %{}) do
  #   # Create account + insert telemetry data
  #   Multi.new()
  #   |> Multi.insert(:account, insert_account_changeset(attrs))
  #   |> Multi.insert(:app_telemetry, fn %{account: account} ->
  #     telemetry_for_create_account_changeset(account)
  #   end)
  #   |> Repo.transaction()
  # end

  @doc """
  Updates a ledger_entry.

  ## Examples

      iex> update_ledger_entry(ledger_entry, %{field: new_value})
      {:ok, %LedgerEntry{}}

      iex> update_ledger_entry(ledger_entry, %{field: bad_value})
      {:error, ...}

  """
  def update_ledger_entry(%LedgerEntry{} = ledger_entry, attrs) do
    raise "TODO"
  end

  @doc """
  Deletes a LedgerEntry.

  ## Examples

      iex> delete_ledger_entry(ledger_entry)
      {:ok, %LedgerEntry{}}

      iex> delete_ledger_entry(ledger_entry)
      {:error, ...}

  """
  def delete_ledger_entry(%LedgerEntry{} = ledger_entry) do
    raise "TODO"
  end

  @doc """
  Returns a data structure for tracking ledger_entry changes.

  ## Examples

      iex> change_ledger_entry(ledger_entry)
      %Todo{...}

  """
  def change_ledger_entry(%LedgerEntry{} = ledger_entry, _attrs \\ %{}) do
    raise "TODO"
  end
end
