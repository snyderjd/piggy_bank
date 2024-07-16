defmodule PiggyBank.TransactionsTest do
  use PiggyBank.DataCase

  alias PiggyBank.Transactions

  describe "transactions" do
    alias PiggyBank.Transactions.Transaction

    import PiggyBank.TransactionsFixtures

    @create_attrs %{
      transaction_type: "debit",
      amount: "100",
      date: ~N[2024-07-01 12:00:00]
    }
    @invalid_attrs %{"transaction_type" => "", "amount" => ""}

    test "list_transactions/0 returns all transactions" do
      transaction = transaction_fixture(@create_attrs)

      transaction_ids =
        %{"all" => true}
        |> Transactions.list_transactions()
        |> Enum.map(fn t -> t.id end)

      assert transaction.id in transaction_ids
    end

    test "get_transaction!/1 returns the transaction with given id" do
      transaction = transaction_fixture(@create_attrs)
      result = Transactions.get_transaction!(transaction.id)

      assert result.id == transaction.id
      assert result.amount == transaction.amount
    end

    test "create_transaction/1 with valid data creates a transaction" do
      other_transaction = transaction_fixture(@create_attrs)

      valid_attrs =
        @create_attrs
        |> Map.put(:account_id, other_transaction.account_id)
        |> Map.put(:ledger_entry_id, other_transaction.ledger_entry_id)
        |> Map.put(:currency_id, other_transaction.currency_id)

      assert {:ok, %Transaction{} = transaction} = Transactions.create_transaction(valid_attrs)
    end

    test "create_transaction/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Transactions.create_transaction(@invalid_attrs)
    end

    test "update_transaction/2 with valid data updates the transaction" do
      transaction = transaction_fixture(@create_attrs)
      update_attrs = %{"amount" => "10000"}

      assert {:ok, %Transaction{} = transaction} =
               Transactions.update_transaction(transaction, update_attrs)
    end

    test "update_transaction/2 with invalid data returns error changeset" do
      transaction = transaction_fixture(@create_attrs)
      result = Transactions.get_transaction!(transaction.id)

      assert {:error, %Ecto.Changeset{}} =
               Transactions.update_transaction(transaction, @invalid_attrs)

      assert transaction.id == result.id
    end

    test "delete_transaction/1 deletes the transaction" do
      transaction = transaction_fixture(@create_attrs)
      assert {:ok, %Transaction{}} = Transactions.delete_transaction(transaction)
      assert_raise Ecto.NoResultsError, fn -> Transactions.get_transaction!(transaction.id) end
    end

    test "change_transaction/1 returns a transaction changeset" do
      transaction = transaction_fixture(@create_attrs)
      assert %Ecto.Changeset{} = Transactions.change_transaction(transaction)
    end
  end
end
