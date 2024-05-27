defmodule PiggyBank.Accounts.Account do
  @moduledoc """
  Schema and relationships for accounts
  """

  use Ecto.Schema

  alias Ecto.Changeset
  alias PiggyBank.AccountTypes.AccountType
  alias PiggyBank.Repo
  alias PiggyBank.Transactions.Transaction
  alias PiggyBank.Users.User

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
    |> Changeset.cast(params, [:name, :usd_current_balance, :account_type_id, :user_id])
    |> Changeset.validate_required([:name])
    |> add_account_type_association(params)
  end

  defp add_account_type_association(changeset, %{account_type: account_type} = _params) do
    Changeset.put_assoc(changeset, :account_type, account_type)
  end

  defp add_account_type_association(changeset, _params), do: changeset
end
