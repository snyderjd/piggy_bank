defmodule PiggyBank.AccountsTest do
  use PiggyBank.DataCase

  alias PiggyBank.Accounts

  describe "accounts" do
    alias PiggyBank.Accounts.Account
    alias PiggyBank.AppTelemetryContext.AppTelemetry

    import PiggyBank.AccountsFixtures

    @create_attrs %{"name" => "Tiger Woods Checking Account"}
    @invalid_attrs %{"name" => ""}

    test "list_accounts/0 returns all accounts" do
      %{account: account, app_telemetry: _telemetry} = account_fixture(@create_attrs)
      assert Accounts.list_accounts() == [account]
    end

    test "get_account!/1 returns the account with given id" do
      %{account: account, app_telemetry: _telemetry} = account_fixture(@create_attrs)
      assert Accounts.get_account!(account.id) == account
    end

    test "create_account/1 with valid data creates a account" do
      valid_attrs = %{"name" => "Charlie Munger Savings Account"}

      assert {:ok, %Account{} = account} = Accounts.create_account(valid_attrs)
    end

    test "create_account/1 with invalid data returns error changeset" do
      assert {:error, :account,
              %Ecto.Changeset{
                action: :insert,
                changes: %{},
                errors: [name: {"can't be blank", [validation: :required]}],
                data: %Account{},
                valid?: false
              }, %{}} = Accounts.create_account(@invalid_attrs)
    end

    test "update_account/2 with valid data updates the account" do
      %{account: account, app_telemetry: _telemetry} =
        account_fixture(%{"name" => "Checking account"})

      update_attrs = %{"name" => "Savings account"}

      assert {:ok, %{account: %Account{}, app_telemetry: %AppTelemetry{}}} =
               Accounts.update_account(account, update_attrs)
    end

    test "update_account/2 with invalid data returns error changeset" do
      account = account_fixture(@create_attrs)
      assert {:error, %Ecto.Changeset{}} = Accounts.update_account(account, @invalid_attrs)
      assert account == Accounts.get_account!(account.id)
    end

    test "delete_account/1 deletes the account" do
      account = account_fixture()
      assert {:ok, %Account{}} = Accounts.delete_account(account)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_account!(account.id) end
    end

    test "change_account/1 returns a account changeset" do
      account = account_fixture(@create_attrs)
      assert %Ecto.Changeset{} = Accounts.change_account(account)
    end
  end
end
