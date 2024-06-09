defmodule PiggyBankWeb.LedgerEntryController do
  use PiggyBankWeb, :controller

  alias PiggyBank.{Accounts, Currencies, LedgerEntries}
  alias PiggyBank.LedgerEntries.LedgerEntry
  alias PiggyBank.Transactions.Transaction

  @spec index(Plug.Conn.t(), map()) :: Plug.Conn.t()
  def index(conn, _params) do
    ledger_entries = LedgerEntries.list_ledger_entries()
    render(conn, :index, ledger_entries: ledger_entries)
  end

  @spec new(Plug.Conn.t(), map()) :: Plug.Conn.t()
  def new(conn, _params) do
    accounts = Accounts.list_accounts()
    currencies = Currencies.list_currencies()
    transactions = [%Transaction{}, %Transaction{}]

    changeset = LedgerEntries.change_ledger_entry(%LedgerEntry{transactions: transactions})

    render(conn, :new,
      changeset: changeset,
      accounts: accounts,
      currencies: currencies,
      transactions: transactions
    )
  end

  @spec create(Plug.Conn.t(), map()) :: Plug.Conn.t()
  def create(conn, %{"ledger_entry" => ledger_entry_params}) do
    case LedgerEntries.create_ledger_entry(ledger_entry_params) do
      {:ok, multi} ->
        conn
        |> put_flash(:info, "Ledger entry created successfully.")
        |> redirect(to: ~p"/ledger_entries/#{multi.ledger_entry}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  @spec show(Plug.Conn.t(), map()) :: Plug.Conn.t()
  def show(conn, %{"id" => id}) do
    ledger_entry = LedgerEntries.get_ledger_entry!(id)
    render(conn, :show, ledger_entry: ledger_entry)
  end

  def edit(conn, %{"id" => id}) do
    ledger_entry = LedgerEntries.get_ledger_entry!(id)
    changeset = LedgerEntries.change_ledger_entry(ledger_entry)
    render(conn, :edit, ledger_entry: ledger_entry, changeset: changeset)
  end

  def update(conn, %{"id" => id, "ledger_entry" => ledger_entry_params}) do
    ledger_entry = LedgerEntries.get_ledger_entry!(id)

    case LedgerEntries.update_ledger_entry(ledger_entry, ledger_entry_params) do
      {:ok, ledger_entry} ->
        conn
        |> put_flash(:info, "Ledger entry updated successfully.")
        |> redirect(to: ~p"/ledger_entries/#{ledger_entry}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, ledger_entry: ledger_entry, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    ledger_entry = LedgerEntries.get_ledger_entry!(id)
    {:ok, _ledger_entry} = LedgerEntries.delete_ledger_entry(ledger_entry)

    conn
    |> put_flash(:info, "Ledger entry deleted successfully.")
    |> redirect(to: ~p"/ledger_entries")
  end
end
