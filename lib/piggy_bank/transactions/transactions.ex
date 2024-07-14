defmodule PiggyBank.Transactions do
  @moduledoc """
  The Transactions context.
  """

  import Ecto.Query, warn: false
  alias Ecto.Changeset
  alias PiggyBank.Repo

  alias PiggyBank.Transactions.Transaction

  @spec list_transactions(map()) :: Scrivener.Page.t() | [Transaction.t()]
  @doc """
  Returns the list of transactions.
  ## Examples
      iex> list_transactions()
      [%Transaction{}, ...]
  """
  def list_transactions(params \\ %{}) do
    from(t in Transaction, as: :t)
    |> filter_by_ledger_entry(params)
    |> order_by([t], desc: t.date)
    |> preload([:account, :currency])
    |> get_transactions(params)
  end

  defp get_transactions(query, %{"all" => true} = _params) do
    Repo.all(query)
  end

  defp get_transactions(query, params) do
    Repo.paginate(query, params)
  end

  defp filter_by_ledger_entry(query, %{"ledger_entry_id" => ledger_entry_id} = _params) do
    query
    |> where([t], t.ledger_entry_id == ^ledger_entry_id)
  end

  defp filter_by_ledger_entry(query, _params), do: query

  @spec get_transaction!(integer()) :: Transaction.t()
  @doc """
  Gets a single transaction.
  Raises if the Transaction does not exist.
  ## Examples
      iex> get_transaction!(123)
      %Transaction{}
  """
  def get_transaction!(id) do
    Transaction
    |> preload([:account, :currency, :ledger_entry])
    |> Repo.get!(id)
  end

  @doc """
  Creates a transaction.

  ## Examples

      iex> create_transaction(%{field: value})
      {:ok, %Transaction{}}

      iex> create_transaction(%{field: bad_value})
      {:error, ...}

  """
  def create_transaction(_attrs \\ %{}) do
    raise "TODO"
  end

  @doc """
  Updates a transaction.

  ## Examples

      iex> update_transaction(transaction, %{field: new_value})
      {:ok, %Transaction{}}

      iex> update_transaction(transaction, %{field: bad_value})
      {:error, ...}

  """
  def update_transaction(%Transaction{} = _transaction, _attrs) do
    raise "TODO"
  end

  @doc """
  Deletes a Transaction.

  ## Examples

      iex> delete_transaction(transaction)
      {:ok, %Transaction{}}

      iex> delete_transaction(transaction)
      {:error, ...}

  """
  def delete_transaction(%Transaction{} = _transaction) do
    raise "TODO"
  end

  @doc """
  Returns a data structure for tracking transaction changes.
  ## Examples
      iex> change_transaction(transaction)
      %Todo{...}
  """
  @spec change_transaction(Transaction.t()) :: Changeset.t()
  def change_transaction(%Transaction{} = transaction, attrs \\ %{}) do
    Transaction.changeset(transaction, attrs)
  end
end
