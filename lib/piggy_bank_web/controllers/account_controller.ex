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

  def create(conn, %{"account" => account_params}) do
    case Accounts.create_account(account_params) do
      {:ok, account} ->
        conn
        |> put_flash(:info, "Account created successfully.")
        |> redirect(to: ~p"/accounts/#{account}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    account = Accounts.get_account!(id)
    render(conn, :show, account: account)
  end

  def edit(conn, %{"id" => id}) do
    account = Accounts.get_account!(id)
    changeset = Accounts.change_account(account)
    render(conn, :edit, account: account, changeset: changeset)
  end

  def update(conn, %{"id" => id, "account" => account_params}) do
    account = Accounts.get_account!(id)

    case Accounts.update_account(account, account_params) do
      {:ok, account} ->
        conn
        |> put_flash(:info, "Account updated successfully.")
        |> redirect(to: ~p"/accounts/#{account}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, account: account, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    account = Accounts.get_account!(id)
    {:ok, _account} = Accounts.delete_account(account)

    conn
    |> put_flash(:info, "Account deleted successfully.")
    |> redirect(to: ~p"/accounts")
  end
end
