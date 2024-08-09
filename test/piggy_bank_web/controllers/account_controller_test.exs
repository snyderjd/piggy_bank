defmodule PiggyBankWeb.AccountControllerTest do
  use PiggyBankWeb.ConnCase

  import PiggyBank.AccountsFixtures
  import PiggyBank.AccountTypesFixtures

  @create_attrs %{name: "Test Savings Account"}
  @update_attrs %{name: "Test Savings Account Update"}
  @invalid_attrs %{name: ""}

  describe "index" do
    test "lists all accounts", %{conn: conn} do
      conn = get(conn, ~p"/accounts")
      assert html_response(conn, 200) =~ "Accounts"
    end
  end

  describe "new account" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/accounts/new")
      assert html_response(conn, 200) =~ "New Account"
    end
  end

  describe "create account" do
    test "redirects to show when data is valid", %{conn: conn} do
      account_type = account_type_fixture(%{"name" => "Liability"})

      attrs =
        Map.put(@create_attrs, :account_type, account_type)

      conn = post(conn, ~p"/accounts", account: attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/accounts/#{id}"

      conn = get(conn, ~p"/accounts/#{id}")
      assert html_response(conn, 200) =~ "Account:"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/accounts", account: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Account"
    end
  end

  describe "edit account" do
    setup [:create_account]

    test "renders form for editing chosen account", %{conn: conn, account: account} do
      conn = get(conn, ~p"/accounts/#{account}/edit")
      assert html_response(conn, 200) =~ "Edit Account"
    end
  end

  describe "update account" do
    setup [:create_account]

    test "redirects when data is valid", %{conn: conn, account: account} do
      conn = put(conn, ~p"/accounts/#{account}", account: @update_attrs)
      assert redirected_to(conn) == ~p"/accounts/#{account}"

      conn = get(conn, ~p"/accounts/#{account}")
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, account: account} do
      conn = put(conn, ~p"/accounts/#{account}", account: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Account"
    end
  end

  describe "delete account" do
    setup [:create_account]

    test "deletes chosen account", %{conn: conn, account: account} do
      conn = delete(conn, ~p"/accounts/#{account}")
      assert redirected_to(conn) == ~p"/accounts"

      assert_error_sent 404, fn ->
        get(conn, ~p"/accounts/#{account}")
      end
    end
  end

  defp create_account(_) do
    %{account: account, app_telemetry: _telemetry} =
      account_fixture(@create_attrs)

    %{account: account}
  end
end
