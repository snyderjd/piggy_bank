defmodule PiggyBank.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias PiggyBank.Repo
  alias PiggyBank.Accounts.Account
  alias PiggyBank.AppTelemetryContext.AppTelemetry
  alias PiggyBank.AppTelemetryContext
  require Logger

  @doc """
  Returns the list of accounts.

  ## Examples

      iex> list_accounts()
      [%Account{}, ...]

  """
  def list_accounts do
    Account
    |> preload([:account_type])
    |> Repo.all()
  end

  @doc """
  Gets a single account.

  Raises if the Account does not exist.

  ## Examples

      iex> get_account!(123)
      %Account{}

  """
  def get_account!(id), do: raise("TODO")

  @doc """
  Creates a account.

  ## Examples

      iex> create_account(%{field: value})
      {:ok, %Account{}}

      iex> create_account(%{field: bad_value})
      {:error, ...}

  """
  def create_account(attrs \\ %{}) do
    # Leverage Repo transactions
    # Create account + insert telemetry data
    Repo.transaction(fn ->
      with {:ok, account} <- insert_account(attrs),
           {:ok, telemetry} <- insert_telemetry_for_create_account(account) do
        {:ok, account}
      else
        error ->
          Logger.error("Transaction failed: #{inspect(error)}")
          Repo.rollback(error)
      end
    end)
  end

  defp insert_account(attrs) do
    %Account{}
    |> Account.changeset(attrs)
    |> Repo.insert()
  end

  defp insert_telemetry_for_create_account(account) do
    IO.inspect(account, label: "insert_telemetry_for_create_account - account")

    # event_name: make machine-readable: Ex: resource_action == account_create
    # description: Human readable
    # metadata: current_user info, any info that is meaningful to this specific event
    #   - tenant_id for multi-tenant app
    #   -
    # Put specific things in meta data to keep from adding nullable associations

    # What to put in here?
    telemetry_params = %{
      event_name: "account_create",
      description: "Create Account #{account.name}",
      metadata: %{},
      date: DateTime.utc_now(),
      account: account
    }

    IO.inspect(telemetry_params, label: "telemetry_params")

    # %AppTelemetry{}
    # |> AppTelemetry.changeset(attrs)
    # |> Repo.insert()

    # AppTelemetryContext.create_app_telemetry(telemetry_params)
    # {:ok, telemetry_params}
  end

  # schema "app_telemetry" do
  #   field :event_name, :string
  #   field :description, :string
  #   field :metadata, :map
  #   field :date, :naive_datetime

  #   belongs_to :user, User
  #   belongs_to :account, Account

  #   timestamps()
  # end

  # Example:
  # Repo.transaction(fn ->
  #   with {:ok, issue} <- Issue.changeset(%Issue{}, issue_params) |> Repo.insert(),
  #        {:ok, _store_issue_from_type} <-
  #          store_issue_from_type(issue.type, issue_type_params, issue.id),
  #         {:ok, telemetry} <- AppTelemetry.create_and_insert_telemetry(issue) do
  #     {:ok, issue}
  #   else
  #     error ->
  #       Logger.error("Transaction failed: #{inspect(error)}")
  #       Repo.rollback(error)
  #   end
  # end)

  @doc """
  Updates a account.

  ## Examples

      iex> update_account(account, %{field: new_value})
      {:ok, %Account{}}

      iex> update_account(account, %{field: bad_value})
      {:error, ...}

  """
  def update_account(%Account{} = account, attrs) do
    raise "TODO"
  end

  @doc """
  Deletes a Account.

  ## Examples

      iex> delete_account(account)
      {:ok, %Account{}}

      iex> delete_account(account)
      {:error, ...}

  """
  def delete_account(%Account{} = account) do
    raise "TODO"
  end

  @doc """
  Returns a data structure for tracking account changes.

  ## Examples

      iex> change_account(account)
      %Todo{...}

  """
  def change_account(%Account{} = account, attrs \\ %{}) do
    Account.changeset(account, attrs)
  end
end
