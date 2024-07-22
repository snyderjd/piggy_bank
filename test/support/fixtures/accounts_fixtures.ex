defmodule PiggyBank.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PiggyBank.Accounts` context.
  """

  alias PiggyBank.AccountTypesFixtures

  @doc """
  Generate a account.
  """
  def account_fixture(attrs \\ %{}) do
    account_type = AccountTypesFixtures.account_type_fixture(%{"name" => "Liability"})

    attrs =
      attrs
      |> Map.put(:account_type, account_type)

    {:ok, multi} =
      attrs
      |> Enum.into(%{})
      |> PiggyBank.Accounts.create_account()

    multi
  end
end
