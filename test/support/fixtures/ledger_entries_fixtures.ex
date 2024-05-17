defmodule PiggyBank.LedgerEntriesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PiggyBank.LedgerEntries` context.
  """

  @doc """
  Generate a ledger_entry.
  """
  def ledger_entry_fixture(attrs \\ %{}) do
    {:ok, ledger_entry} =
      attrs
      |> Enum.into(%{})
      |> PiggyBank.LedgerEntries.create_ledger_entry()

    ledger_entry
  end
end
