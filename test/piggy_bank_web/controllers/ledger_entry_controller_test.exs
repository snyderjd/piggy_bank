defmodule PiggyBankWeb.LedgerEntryControllerTest do
  use PiggyBankWeb.ConnCase

  import PiggyBank.LedgerEntriesFixtures

  @create_attrs %{
    "description" => "Test ledger entry create",
    "date" => ~N[2024-07-01 14:00:00],
    "transactions" => []
  }
  @update_attrs %{}
  @invalid_attrs %{}

  # field :description, :string
  # field :date, :naive_datetime

  describe "index" do
    @tag :skip
    test "lists all ledger_entries", %{conn: conn} do
      conn = get(conn, ~p"/ledger_entries")
      assert html_response(conn, 200) =~ "Listing Ledger entries"
    end
  end

  describe "new ledger_entry" do
    @tag :skip
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/ledger_entries/new")
      assert html_response(conn, 200) =~ "New Ledger entry"
    end
  end

  describe "create ledger_entry" do
    @tag :skip
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/ledger_entries", ledger_entry: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/ledger_entries/#{id}"

      conn = get(conn, ~p"/ledger_entries/#{id}")
      assert html_response(conn, 200) =~ "Ledger entry #{id}"
    end

    @tag :skip
    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/ledger_entries", ledger_entry: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Ledger entry"
    end
  end

  describe "edit ledger_entry" do
    setup [:create_ledger_entry]

    @tag :skip
    test "renders form for editing chosen ledger_entry", %{conn: conn, ledger_entry: ledger_entry} do
      conn = get(conn, ~p"/ledger_entries/#{ledger_entry}/edit")
      assert html_response(conn, 200) =~ "Edit Ledger entry"
    end
  end

  describe "update ledger_entry" do
    setup [:create_ledger_entry]

    @tag :skip
    test "redirects when data is valid", %{conn: conn, ledger_entry: ledger_entry} do
      conn = put(conn, ~p"/ledger_entries/#{ledger_entry}", ledger_entry: @update_attrs)
      assert redirected_to(conn) == ~p"/ledger_entries/#{ledger_entry}"

      conn = get(conn, ~p"/ledger_entries/#{ledger_entry}")
      assert html_response(conn, 200)
    end

    @tag :skip
    test "renders errors when data is invalid", %{conn: conn, ledger_entry: ledger_entry} do
      conn = put(conn, ~p"/ledger_entries/#{ledger_entry}", ledger_entry: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Ledger entry"
    end
  end

  describe "delete ledger_entry" do
    setup [:create_ledger_entry]

    @tag :skip
    test "deletes chosen ledger_entry", %{conn: conn, ledger_entry: ledger_entry} do
      conn = delete(conn, ~p"/ledger_entries/#{ledger_entry}")
      assert redirected_to(conn) == ~p"/ledger_entries"

      assert_error_sent 404, fn ->
        get(conn, ~p"/ledger_entries/#{ledger_entry}")
      end
    end
  end

  defp create_ledger_entry(_) do
    ledger_entry = ledger_entry_fixture()
    %{ledger_entry: ledger_entry}
  end
end
