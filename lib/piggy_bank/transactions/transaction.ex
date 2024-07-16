defmodule PiggyBank.Transactions.Transaction do
  @moduledoc """
  Schema and relationships for transactions
  """

  use Ecto.Schema

  alias Ecto.Changeset
  alias PiggyBank.Accounts.Account
  alias PiggyBank.Currencies.Currency
  alias PiggyBank.LedgerEntries.LedgerEntry

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
    |> Changeset.cast(params, [
      :transaction_type,
      :amount,
      :date,
      :account_id,
      :currency_id,
      :ledger_entry_id
    ])
    |> Changeset.validate_required([:transaction_type, :amount, :date])
    |> Changeset.validate_inclusion(:transaction_type, ["debit", "credit"])
    |> add_account_association(params)
    |> add_currency_association(params)
    |> add_ledger_entry_association(params)
  end

  defp add_account_association(changeset, %{account: account}) do
    Changeset.put_assoc(changeset, :account, account)
  end

  defp add_account_association(changeset, _params), do: changeset

  defp add_currency_association(changeset, %{currency: currency}) do
    Changeset.put_assoc(changeset, :currency, currency)
  end

  defp add_currency_association(changeset, _params), do: changeset

  defp add_ledger_entry_association(changeset, %{ledger_entry: ledger_entry}) do
    Changeset.put_assoc(changeset, :ledger_entry, ledger_entry)
  end

  defp add_ledger_entry_association(changeset, _params), do: changeset
end
