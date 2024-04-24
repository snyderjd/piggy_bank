defmodule PiggyBank.AccountTypesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PiggyBank.AccountTypes` context.
  """

  @doc """
  Generate a account_type.
  """
  def account_type_fixture(attrs \\ %{}) do
    {:ok, account_type} =
      attrs
      |> Enum.into(%{

      })
      |> PiggyBank.AccountTypes.create_account_type()

    account_type
  end
end
