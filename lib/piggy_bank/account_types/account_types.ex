defmodule PiggyBank.AccountTypes do
  @moduledoc """
  The AccountTypes context.
  """

  import Ecto.Query, warn: false
  alias PiggyBank.Repo

  alias PiggyBank.AccountTypes.AccountType

  @doc """
  Returns the list of account_types.

  ## Examples

      iex> list_account_types()
      [%AccountType{}, ...]

  """
  def list_account_types do
    AccountType
    |> Repo.all()
  end

  @doc """
  Gets a single account_type.

  Raises if the Account type does not exist.

  ## Examples

      iex> get_account_type!(123)
      %AccountType{}

  """
  def get_account_type!(id), do: raise "TODO"

  @doc """
  Creates a account_type.

  ## Examples

      iex> create_account_type(%{field: value})
      {:ok, %AccountType{}}

      iex> create_account_type(%{field: bad_value})
      {:error, ...}

  """
  def create_account_type(attrs \\ %{}) do
    raise "TODO"
  end

  @doc """
  Updates a account_type.

  ## Examples

      iex> update_account_type(account_type, %{field: new_value})
      {:ok, %AccountType{}}

      iex> update_account_type(account_type, %{field: bad_value})
      {:error, ...}

  """
  def update_account_type(%AccountType{} = account_type, attrs) do
    raise "TODO"
  end

  @doc """
  Deletes a AccountType.

  ## Examples

      iex> delete_account_type(account_type)
      {:ok, %AccountType{}}

      iex> delete_account_type(account_type)
      {:error, ...}

  """
  def delete_account_type(%AccountType{} = account_type) do
    raise "TODO"
  end

  @doc """
  Returns a data structure for tracking account_type changes.

  ## Examples

      iex> change_account_type(account_type)
      %Todo{...}

  """
  def change_account_type(%AccountType{} = account_type, _attrs \\ %{}) do
    raise "TODO"
  end
end
