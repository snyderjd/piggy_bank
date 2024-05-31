defmodule PiggyBankWeb.LedgerEntryHTML do
  use PiggyBankWeb, :html

  embed_templates "ledger_entry_html/*"

  @doc """
  Renders a ledger_entry form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def ledger_entry_form(assigns)

  @spec format_entry_date(NaiveDateTime.t()) :: binary()
  def format_entry_date(datetime) do
    datetime
    |> NaiveDateTime.to_date()
    |> Date.to_string()
  end
end
