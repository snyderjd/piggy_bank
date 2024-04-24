defmodule PiggyBank.Repo.Migrations.CreateTelemetryTable do
  use Ecto.Migration

  # rename to app_telemetry
  # wire up telemetry
  # integration tests around Repo.transaction
  # - fail one of the operations
  # - test DB => different name
  # - Run test cleanup before test runs
  # Ex: Remove records from accounts table, remove records from app_telemetry >> run tests and validate

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
