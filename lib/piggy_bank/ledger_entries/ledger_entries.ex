defmodule PiggyBank.LedgerEntries do
  @moduledoc """
  The LedgerEntries context.
  """

  import Ecto.Query, warn: false
  alias PiggyBank.Repo

  alias PiggyBank.LedgerEntries.LedgerEntry

  @doc """
  Returns the list of ledger_entries.

  ## Examples

      iex> list_ledger_entries()
      [%LedgerEntry{}, ...]

  """
  def list_ledger_entries do
    raise "TODO"
  end

  @doc """
  Gets a single ledger_entry.

  Raises if the Ledger entry does not exist.

  ## Examples

      iex> get_ledger_entry!(123)
      %LedgerEntry{}

  """
  def get_ledger_entry!(id), do: raise("TODO")

  @doc """
  Creates a ledger_entry.

  ## Examples

      iex> create_ledger_entry(%{field: value})
      {:ok, %LedgerEntry{}}

      iex> create_ledger_entry(%{field: bad_value})
      {:error, ...}

  """
  def create_ledger_entry(attrs \\ %{}) do
    raise "TODO"
  end

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
