defmodule PiggyBank.Currency do
  @moduledoc """
  Schema and relationships for currencies
  """

  use Ecto.Schema

  alias Ecto.Changeset

  @type t :: %__MODULE__{
          name: String.t(),
          code: String.t()
        }

  schema "currencies" do
    field :name, :string
    field :code, :string

    timestamps()
  end

  @spec changeset(map(), map()) :: Changeset.t()
  def changeset(struct, params \\ %{}) do
    struct
    |> Changeset.cast(params, [:name, :code])
    |> Changeset.validate_required([:name, :code])
  end
end
