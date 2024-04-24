defmodule PiggyBankWeb.AccountTypeControllerTest do
  use PiggyBankWeb.ConnCase

  import PiggyBank.AccountTypesFixtures

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  describe "index" do
    test "lists all account_types", %{conn: conn} do
      conn = get(conn, ~p"/account_types")
      assert html_response(conn, 200) =~ "Listing Account types"
    end
  end

  describe "new account_type" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/account_types/new")
      assert html_response(conn, 200) =~ "New Account type"
    end
  end

  describe "create account_type" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/account_types", account_type: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/account_types/#{id}"

      conn = get(conn, ~p"/account_types/#{id}")
      assert html_response(conn, 200) =~ "Account type #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/account_types", account_type: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Account type"
    end
  end

  describe "edit account_type" do
    setup [:create_account_type]

    test "renders form for editing chosen account_type", %{conn: conn, account_type: account_type} do
      conn = get(conn, ~p"/account_types/#{account_type}/edit")
      assert html_response(conn, 200) =~ "Edit Account type"
    end
  end

  describe "update account_type" do
    setup [:create_account_type]

    test "redirects when data is valid", %{conn: conn, account_type: account_type} do
      conn = put(conn, ~p"/account_types/#{account_type}", account_type: @update_attrs)
      assert redirected_to(conn) == ~p"/account_types/#{account_type}"

      conn = get(conn, ~p"/account_types/#{account_type}")
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, account_type: account_type} do
      conn = put(conn, ~p"/account_types/#{account_type}", account_type: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Account type"
    end
  end

  describe "delete account_type" do
    setup [:create_account_type]

    test "deletes chosen account_type", %{conn: conn, account_type: account_type} do
      conn = delete(conn, ~p"/account_types/#{account_type}")
      assert redirected_to(conn) == ~p"/account_types"

      assert_error_sent 404, fn ->
        get(conn, ~p"/account_types/#{account_type}")
      end
    end
  end

  defp create_account_type(_) do
    account_type = account_type_fixture()
    %{account_type: account_type}
  end
end
