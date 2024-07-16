defmodule PiggyBank.Currencies do
  @moduledoc """
  The Currencies context.
  """

  import Ecto.Query, warn: false
  alias PiggyBank.Repo

  alias Ecto.Changeset
  alias PiggyBank.Currencies.Currency

  @doc """
  Returns the list of currencies.
  ## Examples
      iex> list_currencies()
      [%Currency{}, ...]
  """
  @spec list_currencies() :: [Currency.t()]
  def list_currencies do
    Repo.all(Currency)
  end

  @doc """
  Gets a single currency.
  Raises if the Currency does not exist.
  ## Examples
      iex> get_currency!(123)
      %Currency{}
  """
  @spec get_currency!(integer()) :: Currency.t()
  def get_currency!(id), do: Repo.get!(Currency, id)

  @doc """
  Creates a currency.
  ## Examples
      iex> create_currency(%{field: value})
      {:ok, %Currency{}}

      iex> create_currency(%{field: bad_value})
      {:error, ...}
  """
  @spec create_currency(map()) :: {:ok, Currency.t()} | {:error, Changeset.t()}
  def create_currency(attrs \\ %{}) do
    %Currency{}
    |> Currency.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a currency.
  ## Examples
      iex> update_currency(currency, %{field: new_value})
      {:ok, %Currency{}}

      iex> update_currency(currency, %{field: bad_value})
      {:error, ...}
  """
  @spec update_currency(Currency.t(), map()) :: {:ok, Currency.t()} | {:error, Changeset.t()}
  def update_currency(%Currency{} = currency, attrs) do
    currency
    |> Currency.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Deletes a Currency.

  ## Examples

      iex> delete_currency(currency)
      {:ok, %Currency{}}

      iex> delete_currency(currency)
      {:error, ...}

  """
  def delete_currency(%Currency{} = _currency) do
    raise "TODO"
  end

  @doc """
  Returns a data structure for tracking currency changes.

  ## Examples

      iex> change_currency(currency)
      %Todo{...}

  """
  def change_currency(%Currency{} = _currency, _attrs \\ %{}) do
    raise "TODO"
  end
end
