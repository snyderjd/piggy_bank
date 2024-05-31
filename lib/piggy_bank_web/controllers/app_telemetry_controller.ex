defmodule PiggyBankWeb.AppTelemetryController do
  use PiggyBankWeb, :controller

  alias PiggyBank.AppTelemetryContext
  alias PiggyBank.AppTelemetryContext.AppTelemetry

  def index(conn, _params) do
    app_telemetry = AppTelemetryContext.list_app_telemetry()
    render(conn, :index, app_telemetry_collection: app_telemetry)
  end

  def new(conn, _params) do
    changeset = AppTelemetryContext.change_app_telemetry(%AppTelemetry{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"app_telemetry" => app_telemetry_params}) do
    case AppTelemetryContext.create_app_telemetry(app_telemetry_params) do
      {:ok, app_telemetry} ->
        conn
        |> put_flash(:info, "App telemetry created successfully.")
        |> redirect(to: ~p"/app_telemetry/#{app_telemetry}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    app_telemetry = AppTelemetryContext.get_app_telemetry!(id)
    render(conn, :show, app_telemetry: app_telemetry)
  end

  def edit(conn, %{"id" => id}) do
    app_telemetry = AppTelemetryContext.get_app_telemetry!(id)
    changeset = AppTelemetryContext.change_app_telemetry(app_telemetry)
    render(conn, :edit, app_telemetry: app_telemetry, changeset: changeset)
  end

  def update(conn, %{"id" => id, "app_telemetry" => app_telemetry_params}) do
    app_telemetry = AppTelemetryContext.get_app_telemetry!(id)

    case AppTelemetryContext.update_app_telemetry(app_telemetry, app_telemetry_params) do
      {:ok, app_telemetry} ->
        conn
        |> put_flash(:info, "App telemetry updated successfully.")
        |> redirect(to: ~p"/app_telemetry/#{app_telemetry}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, app_telemetry: app_telemetry, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    app_telemetry = AppTelemetryContext.get_app_telemetry!(id)
    {:ok, _app_telemetry} = AppTelemetryContext.delete_app_telemetry(app_telemetry)

    conn
    |> put_flash(:info, "App telemetry deleted successfully.")
    |> redirect(to: ~p"/app_telemetry")
  end
end
