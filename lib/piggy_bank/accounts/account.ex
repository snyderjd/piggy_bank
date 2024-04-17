defmodule PiggyBank.Account do
  @moduledoc """
  Schema and relationships for accounts
  """

  use Ecto.Schema

  alias Ecto.Changeset
  alias PiggyBank.{AccountType, Transaction, User}

  @type t :: %__MODULE__{
          name: String.t(),
          account_type: AccountType.t(),
          user: User.t(),
          usd_current_balance: Decimal.t()
        }

  schema "accounts" do
    field :name, :string
    field :usd_current_balance, :decimal

    timestamps()

    belongs_to :account_type, AccountType
    belongs_to :user, User

    has_many :transactions, Transaction
  end

  @spec changeset(map(), map()) :: Changeset.t()
  def changeset(struct, params \\ %{}) do
    struct
    |> Changeset.cast(params, [:name, :usd_current_balance])
    |> Changeset.validate_required([:name])
    |> Changeset.cast_assoc(:account_type, required: true)
  end
end
