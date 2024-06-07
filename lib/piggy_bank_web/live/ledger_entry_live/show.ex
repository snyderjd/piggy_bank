defmodule PiggyBankWeb.LedgerEntryLive.Show do
  use PiggyBankWeb, :live_view

  alias PiggyBank.LedgerEntries

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:ledger_entry, LedgerEntries.get_ledger_entry!(id))}
  end

  defp page_title(:show), do: "Show Ledger entry"
  defp page_title(:edit), do: "Edit Ledger entry"
end
