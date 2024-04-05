defmodule PiggyBank.Repo.Migrations.CreateInitialTables do
  use Ecto.Migration

  # Add indexes on all the foreign_keys to start

  def up do
    # Create tables
    # users
    create_if_not_exists table(:users) do
      add :name, :string, null: false
      add :email, :string, null: false
      add :password, :string, null: false

      timestamps()
    end

    # currencies
    create_if_not_exists table(:currencies) do
      add :name, :string
      add :code, :string

      timestamps()
    end

    # ledger_entries
    create_if_not_exists table(:ledger_entries) do
      add :description, :string
      add :date, :naive_datetime, null: false

      timestamps()
    end

    # account_types
    create_if_not_exists table(:account_types) do
      add :name, :string, null: false

      timestamps()
    end

    # accounts
    create_if_not_exists table(:accounts) do
      add :name, :string
      add :account_type_id, references(:account_types)
      add :user_id, references(:users)
      add :usd_current_balance, :decimal

      timestamps()
    end

    create_if_not_exists index(:accounts, [:account_type_id])
    create_if_not_exists index(:accounts, [:user_id])

    # transactions
    create_if_not_exists table(:transactions) do
      add :account_id, references(:accounts), null: false
      add :ledger_entry_id, references(:ledger_entries), null: false
      add :currency_id, references(:currencies), null: false
      add :transaction_type, :string, null: false
      add :amount, :decimal, null: false
      add :date, :naive_datetime

      timestamps()
    end

    create_if_not_exists index(:transactions, [:account_id])
    create_if_not_exists index(:transactions, [:ledger_entry_id])
  end

  def down do
    drop_if_exists table(:transactions)
    drop_if_exists table(:accounts)
    drop_if_exists table(:account_types)
    drop_if_exists table(:ledger_entries)
    drop_if_exists table(:currencies)
    drop_if_exists table(:users)
  end

end
