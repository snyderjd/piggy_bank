defmodule PiggyBank.AccountType do
  @moduledoc """
  Schema and relationships for account_types
  """

  use Ecto.Schema

  alias Ecto.Changeset

  @type t :: %__MODULE__{
          name: String.t()
        }

  schema "account_types" do
    field :name, :string

    timestamps()
  end

  @spec changeset(map(), map()) :: Changeset.t()
  def changeset(struct, params \\ %{}) do
    struct
    |> Changeset.cast(params, [:name])
    |> Changeset.validate_required([:name])
  end
end
