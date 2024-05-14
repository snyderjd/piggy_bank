defmodule PiggyBank.AppTelemetryContextTest do
  use PiggyBank.DataCase

  alias PiggyBank.AppTelemetryContext

  describe "app_telemetry" do
    alias PiggyBank.AppTelemetryContext.AppTelemetry

    import PiggyBank.AppTelemetryContextFixtures

    @invalid_attrs %{}

    test "list_app_telemetry/0 returns all app_telemetry" do
      app_telemetry = app_telemetry_fixture()
      assert AppTelemetryContext.list_app_telemetry() == [app_telemetry]
    end

    test "get_app_telemetry!/1 returns the app_telemetry with given id" do
      app_telemetry = app_telemetry_fixture()
      assert AppTelemetryContext.get_app_telemetry!(app_telemetry.id) == app_telemetry
    end

    test "create_app_telemetry/1 with valid data creates a app_telemetry" do
      valid_attrs = %{}

      assert {:ok, %AppTelemetry{} = app_telemetry} = AppTelemetryContext.create_app_telemetry(valid_attrs)
    end

    test "create_app_telemetry/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = AppTelemetryContext.create_app_telemetry(@invalid_attrs)
    end

    test "update_app_telemetry/2 with valid data updates the app_telemetry" do
      app_telemetry = app_telemetry_fixture()
      update_attrs = %{}

      assert {:ok, %AppTelemetry{} = app_telemetry} = AppTelemetryContext.update_app_telemetry(app_telemetry, update_attrs)
    end

    test "update_app_telemetry/2 with invalid data returns error changeset" do
      app_telemetry = app_telemetry_fixture()
      assert {:error, %Ecto.Changeset{}} = AppTelemetryContext.update_app_telemetry(app_telemetry, @invalid_attrs)
      assert app_telemetry == AppTelemetryContext.get_app_telemetry!(app_telemetry.id)
    end

    test "delete_app_telemetry/1 deletes the app_telemetry" do
      app_telemetry = app_telemetry_fixture()
      assert {:ok, %AppTelemetry{}} = AppTelemetryContext.delete_app_telemetry(app_telemetry)
      assert_raise Ecto.NoResultsError, fn -> AppTelemetryContext.get_app_telemetry!(app_telemetry.id) end
    end

    test "change_app_telemetry/1 returns a app_telemetry changeset" do
      app_telemetry = app_telemetry_fixture()
      assert %Ecto.Changeset{} = AppTelemetryContext.change_app_telemetry(app_telemetry)
    end
  end
end
