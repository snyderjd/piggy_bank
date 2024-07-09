defmodule PiggyBankWeb.LedgerEntryLiveTest do
  use PiggyBankWeb.ConnCase

  import Phoenix.LiveViewTest
  import PiggyBank.LedgerEntriesFixtures

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  defp create_ledger_entry(_) do
    ledger_entry = ledger_entry_fixture()
    %{ledger_entry: ledger_entry}
  end

  describe "Index" do
    setup [:create_ledger_entry]

    test "lists all ledger_entries", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, ~p"/ledger_entries")

      assert html =~ "Listing Ledger entries"
    end

    test "saves new ledger_entry", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/ledger_entries")

      assert index_live |> element("a", "New Ledger entry") |> render_click() =~
               "New Ledger entry"

      assert_patch(index_live, ~p"/ledger_entries/new")

      assert index_live
             |> form("#ledger_entry-form", ledger_entry: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#ledger_entry-form", ledger_entry: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/ledger_entries")

      html = render(index_live)
      assert html =~ "Ledger entry created successfully"
    end

    test "updates ledger_entry in listing", %{conn: conn, ledger_entry: ledger_entry} do
      {:ok, index_live, _html} = live(conn, ~p"/ledger_entries")

      assert index_live
             |> element("#ledger_entries-#{ledger_entry.id} a", "Edit")
             |> render_click() =~
               "Edit Ledger entry"

      assert_patch(index_live, ~p"/ledger_entries/#{ledger_entry}/edit")

      assert index_live
             |> form("#ledger_entry-form", ledger_entry: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#ledger_entry-form", ledger_entry: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/ledger_entries")

      html = render(index_live)
      assert html =~ "Ledger entry updated successfully"
    end

    test "deletes ledger_entry in listing", %{conn: conn, ledger_entry: ledger_entry} do
      {:ok, index_live, _html} = live(conn, ~p"/ledger_entries")

      assert index_live
             |> element("#ledger_entries-#{ledger_entry.id} a", "Delete")
             |> render_click()

      refute has_element?(index_live, "#ledger_entries-#{ledger_entry.id}")
    end
  end

  describe "Show" do
    setup [:create_ledger_entry]

    test "displays ledger_entry", %{conn: conn, ledger_entry: ledger_entry} do
      {:ok, _show_live, html} = live(conn, ~p"/ledger_entries/#{ledger_entry}")

      assert html =~ "Show Ledger entry"
    end

    test "updates ledger_entry within modal", %{conn: conn, ledger_entry: ledger_entry} do
      {:ok, show_live, _html} = live(conn, ~p"/ledger_entries/#{ledger_entry}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Ledger entry"

      assert_patch(show_live, ~p"/ledger_entries/#{ledger_entry}/show/edit")

      assert show_live
             |> form("#ledger_entry-form", ledger_entry: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#ledger_entry-form", ledger_entry: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/ledger_entries/#{ledger_entry}")

      html = render(show_live)
      assert html =~ "Ledger entry updated successfully"
    end
  end
end
