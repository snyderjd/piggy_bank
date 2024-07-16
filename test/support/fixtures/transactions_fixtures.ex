defmodule PiggyBank.TransactionsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PiggyBank.Transactions` context.
  """

  import PiggyBank.{AccountsFixtures, CurrenciesFixtures, LedgerEntriesFixtures}

  @doc """
  Generate a transaction.
  """
  def transaction_fixture(attrs \\ %{}) do
    %{account: account} = account_fixture(%{name: "Test account"})

    %{ledger_entry: ledger_entry} =
      ledger_entry_fixture(%{
        description: "Test entry",
        date: ~N[2024-07-01 12:00:00],
        transactions: []
      })

    currency = currency_fixture(%{name: "Test Dollar", code: "TST"})

    attrs =
      attrs
      |> Map.put(:account, account)
      |> Map.put(:ledger_entry, ledger_entry)
      |> Map.put(:currency, currency)

    {:ok, transaction} =
      attrs
      |> Enum.into(%{})
      |> PiggyBank.Transactions.create_transaction()

    transaction
  end
end
