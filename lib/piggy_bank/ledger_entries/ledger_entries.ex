defmodule PiggyBank.LedgerEntries do
  @moduledoc """
  The LedgerEntries context.
  """

  import Ecto.Query, warn: false
  alias Ecto.{Changeset, Multi}
  alias PiggyBank.Repo
  alias PiggyBank.LedgerEntries.LedgerEntry
  alias PiggyBank.AppTelemetryContext.AppTelemetry

  @spec list_ledger_entries(map()) :: Scrivener.Page.t() | [LedgerEntry.t()]
  @doc """
  Returns the list of ledger_entries.

  ## Examples

      iex> list_ledger_entries()
      [%LedgerEntry{}, ...]

  """
  def list_ledger_entries(params) do
    LedgerEntry
    |> preload([:transactions])
    |> order_by([le], desc: le.date)
    |> paginate_ledger_entries(params)
  end

  defp paginate_ledger_entries(query, %{"paginate" => true} = params) do
    Repo.paginate(query, params)
  end

  defp paginate_ledger_entries(query, _params) do
    Repo.all(query)
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
    |> Multi.run(:validate_transactions, fn _repo, %{ledger_entry: ledger_entry} ->
      {total_debits, total_credits} = total_debits_and_credits(ledger_entry.transactions)

      if total_debits == total_credits do
        {:ok, "valid"}
      else
        {:error,
         "Total debits must equal total credits. Debits: #{total_debits}, Credits: #{total_credits}"}
      end
    end)
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
    |> then(fn result ->
      case result do
        {:ok, result} ->
          {:ok, result.ledger_entry}

        {:error, operation, error, changes} ->
          {:error, operation, error, changes}
      end
    end)
  end

  defp total_debits_and_credits(transactions) do
    total_debits =
      transactions
      |> Enum.filter(fn t -> t.transaction_type == "debit" end)
      |> Enum.map(fn t -> Decimal.to_float(t.amount) end)
      |> Enum.sum()

    total_credits =
      transactions
      |> Enum.filter(fn t -> t.transaction_type == "credit" end)
      |> Enum.map(fn t -> Decimal.to_float(t.amount) end)
      |> Enum.sum()

    {total_debits, total_credits}
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
          {"create_transaction",
           "Create Transaction #{transaction.transaction_type} #{transaction.account.name} #{transaction.amount}"}
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
