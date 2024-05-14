defmodule PiggyBank.TransactionsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PiggyBank.Transactions` context.
  """

  @doc """
  Generate a transaction.
  """
  def transaction_fixture(attrs \\ %{}) do
    {:ok, transaction} =
      attrs
      |> Enum.into(%{

      })
      |> PiggyBank.Transactions.create_transaction()

    transaction
  end
end
