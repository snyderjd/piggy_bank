defmodule PiggyBankWeb.TransactionHTML do
  use PiggyBankWeb, :html

  embed_templates "transaction_html/*"

  @doc """
  Renders a transaction form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def transaction_form(assigns)

  @spec format_transaction_date(NaiveDateTime.t()) :: binary()
  def format_transaction_date(transaction_date) do
    transaction_date
    |> NaiveDateTime.to_date()
    |> Date.to_string()
  end
end
