defmodule PiggyBank.Transactions.Transaction do
  @moduledoc """
  Schema and relationships for transactions
  """

  use Ecto.Schema

  alias Ecto.Changeset
  alias PiggyBank.Accounts.Account
  alias PiggyBank.Currencies.Currency
  alias PiggyBank.LedgerEntries.LedgerEntry
  alias PiggyBank.Repo

  @type t :: %__MODULE__{
          account: Account.t(),
          ledger_entry: LedgerEntry.t(),
          currency: Currency.t(),
          transaction_type: String.t(),
          amount: Decimal.t(),
          date: NaiveDateTime.t()
        }

  schema "transactions" do
    field :transaction_type, :string
    field :amount, :decimal
    field :date, :naive_datetime

    timestamps()

    belongs_to :account, Account
    belongs_to :currency, Currency
    belongs_to :ledger_entry, LedgerEntry
  end

  @spec changeset(map(), map()) :: Changeset.t()
  def changeset(struct, params \\ %{}) do
    struct
    |> Changeset.cast(params, [:transaction_type, :amount, :date])
    |> Changeset.validate_required([:transaction_type, :amount, :date])
    |> Changeset.validate_inclusion(:transaction_type, ["debit", "credit"])
    |> Changeset.put_assoc(:account, params.account, required: true)
    |> Changeset.put_assoc(:currency, params.currency, required: true)
    |> Changeset.put_assoc(:ledger_entry, params.ledger_entry, required: true)
  end
end
