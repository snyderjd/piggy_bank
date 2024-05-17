defmodule PiggyBank.AppTelemetryContextFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PiggyBank.AppTelemetryContext` context.
  """

  @doc """
  Generate a app_telemetry.
  """
  def app_telemetry_fixture(attrs \\ %{}) do
    {:ok, app_telemetry} =
      attrs
      |> Enum.into(%{})
      |> PiggyBank.AppTelemetryContext.create_app_telemetry()

    app_telemetry
  end
end
