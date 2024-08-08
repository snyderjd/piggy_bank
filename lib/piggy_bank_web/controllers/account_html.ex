defmodule PiggyBankWeb.AccountHTML do
  use PiggyBankWeb, :html

  import PiggyBankWeb.TransactionHTML

  embed_templates "account_html/*"

  @doc """
  Renders a account form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true
  attr :account_types, :list
  attr :users, :list

  def account_form(assigns)

  def render_account_user(account) do
    if(account.user, do: account.user.name, else: "N/A")
  end
end
