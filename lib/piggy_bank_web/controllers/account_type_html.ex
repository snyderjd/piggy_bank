defmodule PiggyBankWeb.AccountTypeHTML do
  use PiggyBankWeb, :html

  embed_templates "account_type_html/*"

  @doc """
  Renders a account_type form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def account_type_form(assigns)
end
