defmodule PiggyBank.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PiggyBank.Accounts` context.
  """

  @doc """
  Generate a account.
  """
  def account_fixture(attrs \\ %{}) do
    {:ok, multi} =
      attrs
      |> Enum.into(%{})
      |> PiggyBank.Accounts.create_account()

    multi
  end
end
