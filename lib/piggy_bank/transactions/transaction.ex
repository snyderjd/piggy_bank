defmodule PiggyBank.Transaction do
  @moduledoc """
  Schema and relationships for transactions
  """

  use Ecto.Schema

  alias Ecto.Changeset
  alias PiggyBank.{Account, Currency, LedgerEntry}

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
    |> Changeset.cast_assoc(:account, required: true)
    |> Changeset.cast_assoc(:currency, required: true)
    |> Changeset.cast_assoc(:ledger_entry, required: true)
  end
end