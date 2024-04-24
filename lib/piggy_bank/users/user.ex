defmodule PiggyBank.User do
  @moduledoc """
  Schema and relationships for users
  """

  use Ecto.Schema

  alias Ecto.Changeset
  alias PiggyBank.Accounts.Account

  @type t :: %__MODULE__{
          name: String.t(),
          email: String.t(),
          password: String.t()
        }

  schema "users" do
    field :name, :string
    field :email, :string
    field :password, :string
    field :virtual_password, :string, virtual: true

    timestamps()

    has_many :accounts, Account
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> Changeset.cast(params, [:name, :email, :password, :virtual_password])
    |> Changeset.validate_required([:name, :email, :password])
  end
end
