defmodule PiggyBankWeb.AppTelemetryControllerTest do
  use PiggyBankWeb.ConnCase

  import PiggyBank.AppTelemetryContextFixtures

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  describe "index" do
    test "lists all app_telemetry", %{conn: conn} do
      conn = get(conn, ~p"/app_telemetry")
      assert html_response(conn, 200) =~ "Listing App telemetry"
    end
  end

  describe "new app_telemetry" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/app_telemetry/new")
      assert html_response(conn, 200) =~ "New App telemetry"
    end
  end

  describe "create app_telemetry" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/app_telemetry", app_telemetry: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/app_telemetry/#{id}"

      conn = get(conn, ~p"/app_telemetry/#{id}")
      assert html_response(conn, 200) =~ "App telemetry #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/app_telemetry", app_telemetry: @invalid_attrs)
      assert html_response(conn, 200) =~ "New App telemetry"
    end
  end

  describe "edit app_telemetry" do
    setup [:create_app_telemetry]

    test "renders form for editing chosen app_telemetry", %{conn: conn, app_telemetry: app_telemetry} do
      conn = get(conn, ~p"/app_telemetry/#{app_telemetry}/edit")
      assert html_response(conn, 200) =~ "Edit App telemetry"
    end
  end

  describe "update app_telemetry" do
    setup [:create_app_telemetry]

    test "redirects when data is valid", %{conn: conn, app_telemetry: app_telemetry} do
      conn = put(conn, ~p"/app_telemetry/#{app_telemetry}", app_telemetry: @update_attrs)
      assert redirected_to(conn) == ~p"/app_telemetry/#{app_telemetry}"

      conn = get(conn, ~p"/app_telemetry/#{app_telemetry}")
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, app_telemetry: app_telemetry} do
      conn = put(conn, ~p"/app_telemetry/#{app_telemetry}", app_telemetry: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit App telemetry"
    end
  end

  describe "delete app_telemetry" do
    setup [:create_app_telemetry]

    test "deletes chosen app_telemetry", %{conn: conn, app_telemetry: app_telemetry} do
      conn = delete(conn, ~p"/app_telemetry/#{app_telemetry}")
      assert redirected_to(conn) == ~p"/app_telemetry"

      assert_error_sent 404, fn ->
        get(conn, ~p"/app_telemetry/#{app_telemetry}")
      end
    end
  end

  defp create_app_telemetry(_) do
    app_telemetry = app_telemetry_fixture()
    %{app_telemetry: app_telemetry}
  end
end
