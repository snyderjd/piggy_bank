defmodule PiggyBank.Users do
  @moduledoc """
  The Users context.
  """

  import Ecto.Query, warn: false
  alias PiggyBank.Repo

  alias PiggyBank.Users.User

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    raise "TODO"
  end

  @spec get_user!(integer()) :: User.t()
  @doc """
  Gets a single user.
  Raises if the User does not exist.
  ## Examples
      iex> get_user!(123)
      %User{}
  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, ...}

  """
  def create_user(_attrs \\ %{}) do
    raise "TODO"
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, ...}

  """
  def update_user(%User{} = _user, _attrs) do
    raise "TODO"
  end

  @doc """
  Deletes a User.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, ...}

  """
  def delete_user(%User{} = _user) do
    raise "TODO"
  end

  @doc """
  Returns a data structure for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Todo{...}

  """
  def change_user(%User{} = _user, _attrs \\ %{}) do
    raise "TODO"
  end
end
