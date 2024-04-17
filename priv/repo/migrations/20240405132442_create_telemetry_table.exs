defmodule PiggyBank.Repo.Migrations.CreateTelemetryTable do
  use Ecto.Migration

  def up do
    create_if_not_exists table(:telemetry) do
      add :event_name, :string
      add :description, :string
      add :user_id, references(:users)
      add :account_id, references(:accounts)
      add :metadata, :map
      add :date, :naive_datetime

      timestamps()
    end

    create_if_not_exists index(:telemetry, [:user_id])
    create_if_not_exists index(:telemetry, [:account_id])
  end

  def down do
    drop_if_exists table(:telemetry)
  end
end
