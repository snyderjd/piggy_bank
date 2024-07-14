defmodule PiggyBank.AccountTypes do
  @moduledoc """
  The AccountTypes context.
  """

  import Ecto.Query, warn: false

  alias Ecto.Changeset
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

  @spec get_account_type!(integer()) :: AccountType.t()
  @doc """
  Gets a single account_type.
  Raises if the Account type does not exist.
  ## Examples
      iex> get_account_type!(123)
      %AccountType{}
  """
  def get_account_type!(id), do: Repo.get!(AccountType, id)

  @doc """
  Creates a account_type.
  ## Examples
      iex> create_account_type(%{field: value})
      {:ok, %AccountType{}}

      iex> create_account_type(%{field: bad_value})
      {:error, ...}
  """
  @spec create_account_type(map()) :: {:ok, AccountType.t()} | {:error, Changeset.t()}
  def create_account_type(attrs \\ %{}) do
    %AccountType{}
    |> AccountType.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a account_type.
  ## Examples
      iex> update_account_type(account_type, %{field: new_value})
      {:ok, %AccountType{}}

      iex> update_account_type(account_type, %{field: bad_value})
      {:error, ...}
  """
  @spec update_account_type(AccountType.t(), map()) ::
          {:ok, AccountType.t()} | {:error, Changeset.t()}
  def update_account_type(%AccountType{} = account_type, attrs) do
    account_type
    |> AccountType.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a AccountType.

  ## Examples

      iex> delete_account_type(account_type)
      {:ok, %AccountType{}}

      iex> delete_account_type(account_type)
      {:error, ...}

  """
  def delete_account_type(%AccountType{} = _account_type) do
    raise "TODO"
  end

  @doc """
  Returns a data structure for tracking account_type changes.
  ## Examples
      iex> change_account_type(account_type)
      %Todo{...}
  """
  @spec change_account_type(AccountType.t(), map()) :: Changeset.t()
  def change_account_type(%AccountType{} = account_type, attrs \\ %{}) do
    AccountType.changeset(account_type, attrs)
  end
end
