defmodule PiggyBankWeb.CurrencyController do
  use PiggyBankWeb, :controller

  alias PiggyBank.Currencies
  alias PiggyBank.Currencies.Currency

  def index(conn, _params) do
    currencies = Currencies.list_currencies()
    render(conn, :index, currencies: currencies)
  end

  def new(conn, _params) do
    changeset = Currencies.change_currency(%Currency{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"currency" => currency_params}) do
    case Currencies.create_currency(currency_params) do
      {:ok, currency} ->
        conn
        |> put_flash(:info, "Currency created successfully.")
        |> redirect(to: ~p"/currencies/#{currency}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    currency = Currencies.get_currency!(id)
    render(conn, :show, currency: currency)
  end

  def edit(conn, %{"id" => id}) do
    currency = Currencies.get_currency!(id)
    changeset = Currencies.change_currency(currency)
    render(conn, :edit, currency: currency, changeset: changeset)
  end

  def update(conn, %{"id" => id, "currency" => currency_params}) do
    currency = Currencies.get_currency!(id)

    case Currencies.update_currency(currency, currency_params) do
      {:ok, currency} ->
        conn
        |> put_flash(:info, "Currency updated successfully.")
        |> redirect(to: ~p"/currencies/#{currency}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, currency: currency, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    currency = Currencies.get_currency!(id)
    {:ok, _currency} = Currencies.delete_currency(currency)

    conn
    |> put_flash(:info, "Currency deleted successfully.")
    |> redirect(to: ~p"/currencies")
  end
end
