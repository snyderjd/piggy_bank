defmodule PiggyBank.AppTelemetryContext do
  @moduledoc """
  The AppTelemetryContext context.
  """

  import Ecto.Query, warn: false
  alias PiggyBank.Repo

  alias PiggyBank.AppTelemetryContext.AppTelemetry

  @doc """
  Returns the list of app_telemetry.

  ## Examples

      iex> list_app_telemetry()
      [%AppTelemetry{}, ...]

  """
  def list_app_telemetry do
    Repo.all(AppTelemetry)
  end

  @doc """
  Gets a single app_telemetry.

  Raises `Ecto.NoResultsError` if the App telemetry does not exist.

  ## Examples

      iex> get_app_telemetry!(123)
      %AppTelemetry{}

      iex> get_app_telemetry!(456)
      ** (Ecto.NoResultsError)

  """
  def get_app_telemetry!(id), do: Repo.get!(AppTelemetry, id)

  @doc """
  Creates a app_telemetry.

  ## Examples

      iex> create_app_telemetry(%{field: value})
      {:ok, %AppTelemetry{}}

      iex> create_app_telemetry(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_app_telemetry(attrs \\ %{}) do
    %AppTelemetry{}
    |> AppTelemetry.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a app_telemetry.

  ## Examples

      iex> update_app_telemetry(app_telemetry, %{field: new_value})
      {:ok, %AppTelemetry{}}

      iex> update_app_telemetry(app_telemetry, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_app_telemetry(%AppTelemetry{} = app_telemetry, attrs) do
    app_telemetry
    |> AppTelemetry.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a app_telemetry.
  ## Examples
      iex> delete_app_telemetry(app_telemetry)
      {:ok, %AppTelemetry{}}

      iex> delete_app_telemetry(app_telemetry)
      {:error, %Ecto.Changeset{}}
  """
  @spec delete_app_telemetry(AppTelemetry.t()) ::
          {:ok, AppTelemetry.t()} | {:error, Changeset.t()}
  def delete_app_telemetry(%AppTelemetry{} = app_telemetry) do
    Repo.delete(app_telemetry)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking app_telemetry changes.

  ## Examples

      iex> change_app_telemetry(app_telemetry)
      %Ecto.Changeset{data: %AppTelemetry{}}

  """
  def change_app_telemetry(%AppTelemetry{} = app_telemetry, attrs \\ %{}) do
    AppTelemetry.changeset(app_telemetry, attrs)
  end
end
