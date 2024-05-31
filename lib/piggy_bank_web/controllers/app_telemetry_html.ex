defmodule PiggyBankWeb.AppTelemetryHTML do
  use PiggyBankWeb, :html

  embed_templates "app_telemetry_html/*"

  @doc """
  Renders a app_telemetry form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def app_telemetry_form(assigns)
end
