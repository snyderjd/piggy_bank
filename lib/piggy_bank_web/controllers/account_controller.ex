defmodule PiggyBankWeb.AccountController do
  use PiggyBankWeb, :controller

  alias PiggyBank.Accounts
  alias PiggyBank.Accounts.Account
  alias PiggyBank.AccountTypes.AccountType
  alias PiggyBank.Repo
  alias PiggyBank.Users.User

  @spec index(Plug.Conn.t(), map()) :: Plug.Conn.t()
  def index(conn, _params) do
    accounts = Accounts.list_accounts()
    render(conn, :index, accounts: accounts)
  end

  @spec new(Plug.Conn.t(), map()) :: Plug.Conn.t()
  def new(conn, _params) do
    changeset = Accounts.change_account(%Account{})
    account_types = Repo.all(AccountType)
    users = Repo.all(User)

    render(conn, :new, changeset: changeset, account_types: account_types, users: users)
  end

  @spec create(Plug.Conn.t(), map()) :: Plug.Conn.t()
  def create(conn, %{"account" => account_params}) do
    account_types = Repo.all(AccountType)
    users = Repo.all(User)

    case Accounts.create_account(account_params) do
      {:ok, multi} ->
        conn
        |> put_flash(:info, "Account created successfully.")
        |> redirect(to: ~p"/accounts/#{multi.account.id}")

      {:error, :account, %Ecto.Changeset{} = changeset, _changes} ->
        render(conn, :new, changeset: changeset, account_types: account_types, users: users)
    end
  end

  @spec show(Plug.Conn.t(), map()) :: Plug.Conn.t()
  def show(conn, %{"id" => id}) do
    account = Accounts.get_account!(id)
    render(conn, :show, account: account)
  end

  @spec edit(Plug.Conn.t(), map()) :: Plug.Conn.t()
  def edit(conn, %{"id" => id}) do
    account = Accounts.get_account!(id)
    changeset = Accounts.change_account(account)
    account_types = Repo.all(AccountType)
    users = Repo.all(User)

    render(conn, :edit,
      account: account,
      changeset: changeset,
      account_types: account_types,
      users: users
    )
  end

  @spec update(Plug.Conn.t(), map()) :: Plug.Conn.t()
  def update(conn, %{"id" => id, "account" => account_params}) do
    account = Accounts.get_account!(id)
    account_types = Repo.all(AccountType)
    users = Repo.all(User)

    case Accounts.update_account(account, account_params) do
      {:ok, multi} ->
        conn
        |> put_flash(:info, "Account updated successfully.")
        |> redirect(to: ~p"/accounts/#{multi.account.id}")

      {:error, :account, %Ecto.Changeset{} = changeset, _changes_so_far} ->
        render(conn, :edit,
          account: account,
          changeset: changeset,
          account_types: account_types,
          users: users
        )

      {:error, _operation, _value, _changes} ->
        conn
        |> put_flash(:error, "There was an error updating the account")
        |> redirect(to: ~p"/accounts/#{account.id}")
    end
  end

  @spec delete(Plug.Conn.t(), map()) :: Plug.Conn.t()
  def delete(conn, %{"id" => id}) do
    account = Accounts.get_account!(id)
    {:ok, _account} = Accounts.delete_account(account)

    conn
    |> put_flash(:info, "Account deleted successfully.")
    |> redirect(to: ~p"/accounts")
  end
end
