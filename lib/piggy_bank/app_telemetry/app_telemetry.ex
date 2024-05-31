defmodule PiggyBank.AppTelemetryContext.AppTelemetry do
  use Ecto.Schema

  import Ecto.Changeset

  alias PiggyBank.Accounts.Account
  alias PiggyBank.Users.User

  @type t :: %__MODULE__{
          event_name: String.t(),
          description: String.t(),
          user: User.t(),
          account: Account.t(),
          metadata: Map.t(),
          date: NaiveDateTime.t()
        }

  schema "app_telemetry" do
    field :event_name, :string
    field :description, :string
    field :metadata, :map
    field :date, :naive_datetime

    belongs_to :user, User
    belongs_to :account, Account

    timestamps()
  end

  @spec changeset(map(), map()) :: Changeset.t()
  def changeset(app_telemetry, attrs) do
    app_telemetry
    |> cast(attrs, [:event_name, :description, :metadata, :date, :account_id, :user_id])
    |> validate_required([:event_name, :description, :metadata, :date])

    # |> put_assoc(:user, attrs.user)
    # |> put_assoc(:account, attrs.account)
  end
end
