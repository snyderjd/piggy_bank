defmodule PiggyBank.CurrenciesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PiggyBank.Currencies` context.
  """

  @doc """
  Generate a currency.
  """
  def currency_fixture(attrs \\ %{}) do
    {:ok, currency} =
      attrs
      |> Enum.into(%{

      })
      |> PiggyBank.Currencies.create_currency()

    currency
  end
end
