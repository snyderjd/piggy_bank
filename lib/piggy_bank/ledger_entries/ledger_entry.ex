defmodule PiggyBank.LedgerEntries.LedgerEntry do
  @moduledoc """
  Schema and relationships for ledger_entries
  """

  use Ecto.Schema

  alias Ecto.Changeset
  alias PiggyBank.Transactions.Transaction

  @type t :: %__MODULE__{
          description: String.t(),
          date: NaiveDateTime.t(),
          transactions: Transaction.t()
        }

  schema "ledger_entries" do
    field :description, :string
    field :date, :naive_datetime

    timestamps()

    has_many :transactions, Transaction, on_replace: :delete
  end

  @spec changeset(map(), map()) :: map()
  def changeset(struct, params \\ %{}) do
    struct
    |> Changeset.cast(params, [:description, :date])
    |> Changeset.validate_required([:description, :date])
    |> Changeset.cast_assoc(:transactions,
      with: &Transaction.changeset/2,
      sort_param: :transactions_sort,
      drop_param: :transactions_drop
    )
  end
end
