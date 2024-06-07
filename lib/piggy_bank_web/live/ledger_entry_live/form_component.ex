defmodule PiggyBankWeb.LedgerEntryLive.FormComponent do
  use PiggyBankWeb, :live_component

  alias PiggyBank.LedgerEntries

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage ledger_entry records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="ledger_entry-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >

        <:actions>
          <.button phx-disable-with="Saving...">Save Ledger entry</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{ledger_entry: ledger_entry} = assigns, socket) do
    changeset = LedgerEntries.change_ledger_entry(ledger_entry)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"ledger_entry" => ledger_entry_params}, socket) do
    changeset =
      socket.assigns.ledger_entry
      |> LedgerEntries.change_ledger_entry(ledger_entry_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"ledger_entry" => ledger_entry_params}, socket) do
    save_ledger_entry(socket, socket.assigns.action, ledger_entry_params)
  end

  defp save_ledger_entry(socket, :edit, ledger_entry_params) do
    case LedgerEntries.update_ledger_entry(socket.assigns.ledger_entry, ledger_entry_params) do
      {:ok, ledger_entry} ->
        notify_parent({:saved, ledger_entry})

        {:noreply,
         socket
         |> put_flash(:info, "Ledger entry updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_ledger_entry(socket, :new, ledger_entry_params) do
    case LedgerEntries.create_ledger_entry(ledger_entry_params) do
      {:ok, ledger_entry} ->
        notify_parent({:saved, ledger_entry})

        {:noreply,
         socket
         |> put_flash(:info, "Ledger entry created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
