defmodule PiggyBankWeb.AccountTypeController do
  use PiggyBankWeb, :controller

  alias PiggyBank.AccountTypes
  alias PiggyBank.AccountTypes.AccountType

  @spec index(Plug.Conn.t(), map()) :: Plug.Conn.t()
  def index(conn, _params) do
    account_types = AccountTypes.list_account_types()
    render(conn, :index, account_types: account_types)
  end

  @spec new(Plug.Conn.t(), map()) :: Plug.Conn.t()
  def new(conn, _params) do
    changeset = AccountTypes.change_account_type(%AccountType{})
    render(conn, :new, changeset: changeset)
  end

  @spec create(Plug.Conn.t(), map()) :: Plug.Conn.t()
  def create(conn, %{"account_type" => account_type_params}) do
    case AccountTypes.create_account_type(account_type_params) do
      {:ok, account_type} ->
        conn
        |> put_flash(:info, "Account type created successfully.")
        |> redirect(to: ~p"/account_types/#{account_type}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  @spec show(Plug.Conn.t(), map()) :: Plug.Conn.t()
  def show(conn, %{"id" => id}) do
    account_type = AccountTypes.get_account_type!(id)
    render(conn, :show, account_type: account_type)
  end

  @spec edit(Plug.Conn.t(), map()) :: Plug.Conn.t()
  def edit(conn, %{"id" => id}) do
    account_type = AccountTypes.get_account_type!(id)
    changeset = AccountTypes.change_account_type(account_type)
    render(conn, :edit, account_type: account_type, changeset: changeset)
  end

  @spec update(Plug.Conn.t(), map()) :: Plug.Conn.t()
  def update(conn, %{"id" => id, "account_type" => account_type_params}) do
    account_type = AccountTypes.get_account_type!(id)

    case AccountTypes.update_account_type(account_type, account_type_params) do
      {:ok, account_type} ->
        conn
        |> put_flash(:info, "Account type updated successfully.")
        |> redirect(to: ~p"/account_types/#{account_type}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, account_type: account_type, changeset: changeset)
    end
  end

  @spec delete(Plug.Conn.t(), map()) :: Plug.Conn.t()
  def delete(conn, %{"id" => id}) do
    account_type = AccountTypes.get_account_type!(id)
    {:ok, _account_type} = AccountTypes.delete_account_type(account_type)

    conn
    |> put_flash(:info, "Account type deleted successfully.")
    |> redirect(to: ~p"/account_types")
  end
end
