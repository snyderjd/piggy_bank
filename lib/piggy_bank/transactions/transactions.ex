defmodule PiggyBank.Transactions do
  @moduledoc """
  The Transactions context.
  """

  import Ecto.Query, warn: false
  alias PiggyBank.Repo

  alias PiggyBank.Transactions.Transaction

  @spec list_transactions() :: [Transaction.t()]
  @doc """
  Returns the list of transactions.
  ## Examples
      iex> list_transactions()
      [%Transaction{}, ...]
  """
  def list_transactions do
    Transaction
    |> preload([:account, :currency])
    |> Repo.all()
  end

  @spec get_transaction!(integer()) :: Transaction.t()
  @doc """
  Gets a single transaction.
  Raises if the Transaction does not exist.
  ## Examples
      iex> get_transaction!(123)
      %Transaction{}
  """
  def get_transaction!(id), do: Repo.get!(Transaction, id)

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
  def change_transaction(%Transaction{} = _transaction, _attrs \\ %{}) do
    raise "TODO"
  end
end
