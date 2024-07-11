defmodule PiggyBankWeb.LedgerEntryLive.FormComponent do
  use PiggyBankWeb, :live_component

  alias PiggyBank.LedgerEntries
  alias PiggyBank.LedgerEntries.LedgerEntry

  @impl true
  def render(assigns) do
    IO.inspect(assigns, label: "assigns")

    ~H"""
    <div>
      <%= if @flash[:error] do %>
        <.flash kind={:error} flash={@flash["error"]} />
      <% end %>

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
        <.input field={@form[:date]} label="Date" type="datetime-local" />
        <.input field={@form[:description]} label="Description" type="text" />

        <.inputs_for :let={t} field={@form[:transactions]}>
          <.header>Transaction</.header>
          <.input type="hidden" name="ledger_entry[transactions_sort][]" value={t.index} />
          <.input type="datetime-local" label="Date" field={t[:date]} />
          <.input
            label="Transaction Type"
            field={t[:transaction_type]}
            placeholder="debit/credit"
            type="select"
            options={["debit", "credit"]}
          />
          <.input
            field={t[:account_id]}
            label="Account"
            type="select"
            options={Enum.map(@accounts, fn a -> {a.name, a.id} end)}
          />
          <.input
            field={t[:currency_id]}
            label="Currency"
            type="select"
            options={Enum.map(@currencies, fn c -> {c.name, c.id} end)}
          />
          <.input type="text" label="Amount" field={t[:amount]} />
          <button
            type="button"
            name="ledger_entry[transactions_drop][]"
            value={t.index}
            phx-click={JS.dispatch("change")}
          >
            <.icon name="hero-x-mark" class="w-6 h-6 relative top-2" />
          </button>
        </.inputs_for>

        <input type="hidden" name="ledger_entry[transactions_drop][]" />

        <div class="mt-2 flex items-center justify-between gap-6">
          <button
            type="button"
            name="ledger_entry[transactions_sort][]"
            value="new"
            class="rounded-lg bg-zinc-900 hover:bg-zinc-700 py-2 px-3 text-sm font-semibold leading-6 text-white active:text-white/80"
            phx-click={JS.dispatch("change")}
          >
            Add Transaction
          </button>
        </div>

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

      {:error, operation, error, changes} ->
        IO.inspect(operation, label: "operation")
        IO.inspect(changes, label: "changes")

        # renders the flash error on the LedgerEntryLive.Index list
        # updated_socket =
        #   socket
        #   |> put_flash(:error, error)
        #   |> push_patch(to: socket.assigns.patch)
          # |> assign_form(LedgerEntry.changeset(changes.ledger_entry))

        # re-renders the :new form but doesn't render the flash error
        updated_socket =
          socket
          |> put_flash(:error, error)
          # |> push_patch(to: socket.assigns.patch)
          |> assign_form(LedgerEntry.changeset(changes.ledger_entry))

        {:noreply, updated_socket}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
