defmodule PiggyBank.LedgerEntriesTest do
  use PiggyBank.DataCase

  alias PiggyBank.LedgerEntries

  describe "ledger_entries" do
    alias PiggyBank.LedgerEntries.LedgerEntry

    import PiggyBank.LedgerEntriesFixtures

    @invalid_attrs %{}

    test "list_ledger_entries/0 returns all ledger_entries" do
      ledger_entry = ledger_entry_fixture()
      assert LedgerEntries.list_ledger_entries() == [ledger_entry]
    end

    test "get_ledger_entry!/1 returns the ledger_entry with given id" do
      ledger_entry = ledger_entry_fixture()
      assert LedgerEntries.get_ledger_entry!(ledger_entry.id) == ledger_entry
    end

    test "create_ledger_entry/1 with valid data creates a ledger_entry" do
      valid_attrs = %{}

      assert {:ok, %LedgerEntry{} = ledger_entry} = LedgerEntries.create_ledger_entry(valid_attrs)
    end

    test "create_ledger_entry/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = LedgerEntries.create_ledger_entry(@invalid_attrs)
    end

    test "update_ledger_entry/2 with valid data updates the ledger_entry" do
      ledger_entry = ledger_entry_fixture()
      update_attrs = %{}

      assert {:ok, %LedgerEntry{} = ledger_entry} = LedgerEntries.update_ledger_entry(ledger_entry, update_attrs)
    end

    test "update_ledger_entry/2 with invalid data returns error changeset" do
      ledger_entry = ledger_entry_fixture()
      assert {:error, %Ecto.Changeset{}} = LedgerEntries.update_ledger_entry(ledger_entry, @invalid_attrs)
      assert ledger_entry == LedgerEntries.get_ledger_entry!(ledger_entry.id)
    end

    test "delete_ledger_entry/1 deletes the ledger_entry" do
      ledger_entry = ledger_entry_fixture()
      assert {:ok, %LedgerEntry{}} = LedgerEntries.delete_ledger_entry(ledger_entry)
      assert_raise Ecto.NoResultsError, fn -> LedgerEntries.get_ledger_entry!(ledger_entry.id) end
    end

    test "change_ledger_entry/1 returns a ledger_entry changeset" do
      ledger_entry = ledger_entry_fixture()
      assert %Ecto.Changeset{} = LedgerEntries.change_ledger_entry(ledger_entry)
    end
  end
end
