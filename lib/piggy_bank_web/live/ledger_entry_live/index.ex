defmodule PiggyBankWeb.LedgerEntryLive.Index do
  use PiggyBankWeb, :live_view

  alias PiggyBank.Accounts
  alias PiggyBank.Currencies
  alias PiggyBank.LedgerEntries
  alias PiggyBank.LedgerEntries.LedgerEntry
  alias PiggyBank.Transactions.Transaction

  @impl true
  @spec mount(any(), any(), Phoenix.LiveView.Socket.t()) :: {:ok, any()}
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  @spec handle_params(any(), any(), %{
          :assigns => atom() | %{:live_action => :edit | :index | :new, optional(any()) => any()},
          optional(any()) => any()
        }) :: {:noreply, map()}
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Ledger entry")
    |> assign(:ledger_entry, LedgerEntries.get_ledger_entry!(id))
  end

  defp apply_action(socket, :new, _params) do
    accounts = Accounts.list_accounts()
    currencies = Currencies.list_currencies()
    transactions = [%Transaction{}]

    socket
    |> assign(:page_title, "New Ledger entry")
    |> assign(:ledger_entry, %LedgerEntry{transactions: transactions})
    |> assign(:accounts, accounts)
    |> assign(:currencies, currencies)
  end

  defp apply_action(socket, :index, params) do
    ledger_entries =
      params
      |> Map.put("paginate", true)
      |> LedgerEntries.list_ledger_entries()

    socket
    |> stream(:ledger_entries, ledger_entries, reset: true)
    |> assign(:page_number, ledger_entries.page_number)
    |> assign(:page_size, ledger_entries.page_size)
    |> assign(:total_entries, ledger_entries.total_entries)
    |> assign(:total_pages, ledger_entries.total_pages)
    |> assign(:page_title, "Listing Ledger Entries")
    |> assign(:ledger_entry, nil)
  end

  @impl true
  def handle_info({PiggyBankWeb.LedgerEntryLive.FormComponent, {:saved, ledger_entry}}, socket) do
    {:noreply, stream_insert(socket, :ledger_entries, ledger_entry)}
  end

  @impl true
  def handle_event("nav", %{"page" => page}, socket) do
    # https://fullstackphoenix.com/tutorials/pagination-with-phoenix-liveview
    {:noreply, push_patch(socket, to: ~p"/ledger_entries?page=#{page}")}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    ledger_entry = LedgerEntries.get_ledger_entry!(id)
    {:ok, _} = LedgerEntries.delete_ledger_entry(ledger_entry)

    {:noreply, stream_delete(socket, :ledger_entries, ledger_entry)}
  end

  @spec format_entry_date(NaiveDateTime.t()) :: binary()
  def format_entry_date(datetime) do
    datetime
    |> NaiveDateTime.to_date()
    |> Date.to_string()
  end
end
