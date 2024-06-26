defmodule PiggyBank.LedgerEntries do
  @moduledoc """
  The LedgerEntries context.
  """

  import Ecto.Query, warn: false
  alias Ecto.{Changeset, Multi}
  alias PiggyBank.Repo
  alias PiggyBank.LedgerEntries.LedgerEntry
  alias PiggyBank.Transactions.Transaction
  alias PiggyBank.AppTelemetryContext.AppTelemetry

  @spec list_ledger_entries :: [LedgerEntry.t()]
  @doc """
  Returns the list of ledger_entries.

  ## Examples

      iex> list_ledger_entries()
      [%LedgerEntry{}, ...]

  """
  def list_ledger_entries do
    LedgerEntry
    |> preload([:transactions])
    |> Repo.all()
  end

  @spec get_ledger_entry!(integer()) :: LedgerEntry.t()
  @doc """
  Gets a single ledger_entry. Raises if the Ledger entry does not exist.
  ## Examples
      iex> get_ledger_entry!(123)
      %LedgerEntry{}
  """
  def get_ledger_entry!(id) do
    LedgerEntry
    |> preload(transactions: [:account, :currency])
    |> Repo.get!(id)
  end

  @doc """
  Creates a ledger_entry.
  ## Examples
      iex> create_ledger_entry(%{field: value})
      {:ok, %LedgerEntry{}}
      iex> create_ledger_entry(%{field: bad_value})
      {:error, ...}
  """
  @spec create_ledger_entry(map()) :: {:ok, map()} | {:error, any()}
  def create_ledger_entry(attrs \\ %{}) do
    Multi.new()
    |> Multi.insert(:ledger_entry, LedgerEntry.changeset(%LedgerEntry{}, attrs))
    |> Multi.insert(:ledger_entry_telemetry, fn %{ledger_entry: ledger_entry} ->
      telemetry_params = build_ledger_entry_telemetry_params(:create, ledger_entry)

      AppTelemetry.changeset(%AppTelemetry{}, telemetry_params)
    end)
    |> Multi.run(:transactions_telemetry, fn repo, %{ledger_entry: ledger_entry} ->
      telemetry_records =
        Enum.map(ledger_entry.transactions, fn transaction ->
          t = repo.preload(transaction, account: :user)
          params = build_transaction_telemetry_params(:create, t)

          %AppTelemetry{}
          |> AppTelemetry.changeset(params)
          |> repo.insert!()
        end)

      {:ok, telemetry_records}
    end)
    |> Repo.transaction()
  end

  defp build_ledger_entry_telemetry_params(action, ledger_entry) do
    {event_name, description} =
      case action do
        :create ->
          {"create_ledger_entry", "Create Ledger Entry #{ledger_entry.description}"}
      end

    %{
      event_name: event_name,
      description: description,
      metadata: %{
        id: ledger_entry.id,
        description: ledger_entry.description,
        date: ledger_entry.date
      },
      date: DateTime.utc_now(),
      account: nil,
      user: nil
    }
  end

  defp build_transaction_telemetry_params(action, transaction) do
    {event_name, description} =
      case action do
        :create ->
          {"create_transaction", "Create Transaction #{transaction.transaction_type} #{transaction.account.name} #{transaction.amount}"}
      end

    %{
      event_name: event_name,
      description: description,
      metadata: %{
        id: transaction.id,
        transaction_type: transaction.transaction_type,
        amount: transaction.amount,
        date: transaction.date,
        account_id: transaction.account_id,
        currency_id: transaction.currency_id,
        ledger_entry_id: transaction.ledger_entry_id
      },
      date: transaction.date,
      account_id: transaction.account_id,
      user_id: transaction.account.user_id
    }
  end

  @doc """
  Updates a ledger_entry.

  ## Examples

      iex> update_ledger_entry(ledger_entry, %{field: new_value})
      {:ok, %LedgerEntry{}}

      iex> update_ledger_entry(ledger_entry, %{field: bad_value})
      {:error, ...}

  """
  def update_ledger_entry(%LedgerEntry{} = _ledger_entry, _attrs) do
    raise "TODO"
  end

  @doc """
  Deletes a LedgerEntry.

  ## Examples

      iex> delete_ledger_entry(ledger_entry)
      {:ok, %LedgerEntry{}}

      iex> delete_ledger_entry(ledger_entry)
      {:error, ...}

  """
  def delete_ledger_entry(%LedgerEntry{} = _ledger_entry) do
    raise "TODO"
  end

  @doc """
  Returns a data structure for tracking ledger_entry changes.
  ## Examples
      iex> change_ledger_entry(ledger_entry)
      %Todo{...}
  """
  @spec change_ledger_entry(LedgerEntry.t(), map()) :: Changeset.t()
  def change_ledger_entry(%LedgerEntry{} = ledger_entry, attrs \\ %{}) do
    LedgerEntry.changeset(ledger_entry, attrs)
  end
end
