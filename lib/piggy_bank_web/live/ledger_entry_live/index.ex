defmodule PiggyBankWeb.LedgerEntryLive.Index do
  use PiggyBankWeb, :live_view

  alias PiggyBank.LedgerEntries
  alias PiggyBank.LedgerEntries.LedgerEntry

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :ledger_entries, LedgerEntries.list_ledger_entries())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Ledger entry")
    |> assign(:ledger_entry, LedgerEntries.get_ledger_entry!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Ledger entry")
    |> assign(:ledger_entry, %LedgerEntry{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Ledger entries")
    |> assign(:ledger_entry, nil)
  end

  @impl true
  def handle_info({PiggyBankWeb.LedgerEntryLive.FormComponent, {:saved, ledger_entry}}, socket) do
    {:noreply, stream_insert(socket, :ledger_entries, ledger_entry)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    ledger_entry = LedgerEntries.get_ledger_entry!(id)
    {:ok, _} = LedgerEntries.delete_ledger_entry(ledger_entry)

    {:noreply, stream_delete(socket, :ledger_entries, ledger_entry)}
  end
end
