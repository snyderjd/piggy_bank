defmodule PiggyBank.LedgerEntry do
  @moduledoc """
  Schema and relationships for ledger_entries
  """

  use Ecto.Schema

  alias Ecto.Changeset
  alias PiggyBank.Transaction

  @type t :: %__MODULE__{
          description: String.t(),
          date: NaiveDateTime.t(),
          transactions: Transaction.t()
        }

  schema "ledger_entries" do
    field :description, :string
    field :date, :naive_datetime

    timestamps()

    has_many :transactions, Transaction
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> Changeset.cast(params, [:description, :date])
    |> Changeset.validate_required([:description, :date])
  end
end
