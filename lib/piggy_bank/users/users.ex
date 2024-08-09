defmodule PiggyBank.Users do
  @moduledoc """
  The Users context.
  """

  import Ecto.Query, warn: false

  alias Ecto.Changeset
  alias PiggyBank.Repo
  alias PiggyBank.Users.User

  @doc """
  Returns the list of users.
  ## Examples
      iex> list_users()
      [%User{}, ...]
  """
  @spec list_users :: [User.t()]
  def list_users do
    Repo.all(User)
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
  @spec create_user(map()) :: {:ok, User.t()} | {:error, Changeset.t()}
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.
  ## Examples
      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, ...}
  """
  @spec update_user(User.t(), map()) :: {:ok, User.t()} | {:error, Changeset.t()}
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a User.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, ...}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns a data structure for tracking user changes.
  ## Examples
      iex> change_user(user)
      %Todo{...}
  """
  @spec change_user(User.t(), map()) :: Changeset.t()
  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end
end
