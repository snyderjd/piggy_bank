defmodule PiggyBank.AccountTypesTest do
  use PiggyBank.DataCase

  alias PiggyBank.AccountTypes

  describe "account_types" do
    alias PiggyBank.AccountTypes.AccountType

    import PiggyBank.AccountTypesFixtures

    @invalid_attrs %{}

    test "list_account_types/0 returns all account_types" do
      account_type = account_type_fixture()
      assert AccountTypes.list_account_types() == [account_type]
    end

    test "get_account_type!/1 returns the account_type with given id" do
      account_type = account_type_fixture()
      assert AccountTypes.get_account_type!(account_type.id) == account_type
    end

    test "create_account_type/1 with valid data creates a account_type" do
      valid_attrs = %{}

      assert {:ok, %AccountType{} = account_type} = AccountTypes.create_account_type(valid_attrs)
    end

    test "create_account_type/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = AccountTypes.create_account_type(@invalid_attrs)
    end

    test "update_account_type/2 with valid data updates the account_type" do
      account_type = account_type_fixture()
      update_attrs = %{}

      assert {:ok, %AccountType{} = account_type} =
               AccountTypes.update_account_type(account_type, update_attrs)
    end

    test "update_account_type/2 with invalid data returns error changeset" do
      account_type = account_type_fixture()

      assert {:error, %Ecto.Changeset{}} =
               AccountTypes.update_account_type(account_type, @invalid_attrs)

      assert account_type == AccountTypes.get_account_type!(account_type.id)
    end

    test "delete_account_type/1 deletes the account_type" do
      account_type = account_type_fixture()
      assert {:ok, %AccountType{}} = AccountTypes.delete_account_type(account_type)
      assert_raise Ecto.NoResultsError, fn -> AccountTypes.get_account_type!(account_type.id) end
    end

    test "change_account_type/1 returns a account_type changeset" do
      account_type = account_type_fixture()
      assert %Ecto.Changeset{} = AccountTypes.change_account_type(account_type)
    end
  end
end
