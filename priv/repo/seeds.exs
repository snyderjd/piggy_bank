# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     PiggyBank.Repo.insert!(%PiggyBank.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias PiggyBank.Accounts.Account
alias PiggyBank.AccountTypes.AccountType
alias PiggyBank.{Currency, LedgerEntry, Repo, Transaction, User}

# Bcrypt.hash_pwd_salt("password123")
# "$2b$12$ezayYzr2qcPUiGCXmhvjG.I6Y0Y1fP32WDY9xac4F5HzVq7daO4I2"
# users
warren_buffett =
  Repo.insert!(%User{
    name: "Warren Buffett",
    email: "warren.buffett@testuser.com",
    password: "$2b$12$ezayYzr2qcPUiGCXmhvjG.I6Y0Y1fP32WDY9xac4F5HzVq7daO4I2"
  })

dwight_schrute =
  Repo.insert!(%User{
    name: "Dwight Schrute",
    email: "dwight.schrute@testuser.com",
    password: "$2b$12$ezayYzr2qcPUiGCXmhvjG.I6Y0Y1fP32WDY9xac4F5HzVq7daO4I2"
  })

# currencies
usd = Repo.insert!(%Currency{name: "US Dollar", code: "USD"})
_eur = Repo.insert!(%Currency{name: "Euro", code: "EUR"})
_gpb = Repo.insert!(%Currency{name: "British Pound", code: "GBP"})

# account_types
asset = Repo.insert!(%AccountType{name: "Asset"})
liability = Repo.insert!(%AccountType{name: "Liability"})
_equity = Repo.insert!(%AccountType{name: "Equity"})
revenue = Repo.insert!(%AccountType{name: "Revenue"})
_expense = Repo.insert!(%AccountType{name: "Expense"})

# accounts
cash = Repo.insert!(%Account{name: "Cash", usd_current_balance: 0, account_type: asset})

warren_buffett_checking =
  Repo.insert!(%Account{
    name: "Warren Buffett Checking",
    usd_current_balance: 0,
    account_type: liability,
    user: warren_buffett
  })

dwight_schrute_checking =
  Repo.insert!(%Account{
    name: "Dwight Schrute Checking",
    usd_current_balance: 0,
    account_type: liability,
    user: dwight_schrute
  })

fee_revenue =
  Repo.insert!(%Account{name: "Fee Revenue", usd_current_balance: 0, account_type: revenue})

# transactions + ledger_entries
# Warren Buffett deposits 1_000
deposits_1000 =
  Repo.insert!(%LedgerEntry{
    description: "debit cash 1000, credit Warren Buffett Checking 1000",
    date: NaiveDateTime.new!(2024, 4, 12, 0, 0, 0)
  })

_debit_cash_1000 =
  Repo.insert!(%Transaction{
    transaction_type: "debit",
    amount: 1000.00,
    date: NaiveDateTime.new!(2024, 4, 12, 0, 0, 0),
    account: cash,
    currency: usd,
    ledger_entry: deposits_1000
  })

_credit_checking_1000 =
  Repo.insert!(%Transaction{
    transaction_type: "credit",
    amount: 1000.00,
    date: NaiveDateTime.new!(2024, 4, 12, 0, 0, 0),
    account: warren_buffett_checking,
    currency: usd,
    ledger_entry: deposits_1000
  })

# Warren Buffett withdraws 250
withdraws_250 =
  Repo.insert!(%LedgerEntry{
    description: "credit cash 250, debit Warren Buffett Checking 250",
    date: NaiveDateTime.new!(2024, 4, 14, 0, 0, 0)
  })

_credit_cash_250 =
  Repo.insert!(%Transaction{
    transaction_type: "credit",
    amount: 250.00,
    date: NaiveDateTime.new!(2024, 4, 14, 0, 0, 0),
    account: cash,
    currency: usd,
    ledger_entry: withdraws_250
  })

_debit_checking_250 =
  Repo.insert!(%Transaction{
    transaction_type: "debit",
    amount: 250.00,
    date: NaiveDateTime.new!(2024, 4, 14, 0, 0, 0),
    account: warren_buffett_checking,
    currency: usd,
    ledger_entry: withdraws_250
  })

# Warren Buffett transfers 100 to Dwight Schrute
transfers_100 =
  Repo.insert!(%LedgerEntry{
    description: "debit Warren Buffett Checking 100, credit Dwight Schrute Checking 100",
    date: NaiveDateTime.new!(2024, 4, 15, 0, 0, 0)
  })

_debit_wb_100 =
  Repo.insert!(%Transaction{
    transaction_type: "debit",
    amount: 100.00,
    date: NaiveDateTime.new!(2024, 4, 15, 0, 0, 0),
    account: warren_buffett_checking,
    currency: usd,
    ledger_entry: transfers_100
  })

_credit_ds_100 =
  Repo.insert!(%Transaction{
    transaction_type: "credit",
    amount: 100.00,
    date: NaiveDateTime.new!(2024, 4, 15, 0, 0, 0),
    account: dwight_schrute_checking,
    currency: usd,
    ledger_entry: transfers_100
  })

# Charge $5 fee to Warren Buffett
wb_fee_5 =
  Repo.insert!(%LedgerEntry{
    description: "credit Fee Revenue 5, debit Warren Buffett Checking 5",
    date: NaiveDateTime.new!(2024, 4, 18, 0, 0, 0)
  })

_credit_fee_revenue_5_wb =
  Repo.insert!(%Transaction{
    transaction_type: "credit",
    amount: 5.00,
    date: NaiveDateTime.new!(2024, 4, 18, 0, 0, 0),
    account: fee_revenue,
    currency: usd,
    ledger_entry: wb_fee_5
  })

_debit_wb_5 =
  Repo.insert!(%Transaction{
    transaction_type: "debit",
    amount: 5.00,
    date: NaiveDateTime.new!(2024, 4, 18, 0, 0, 0),
    account: warren_buffett_checking,
    currency: usd,
    ledger_entry: wb_fee_5
  })

# Charge $5 fee to Dwight Schrute
ds_fee_5 =
  Repo.insert!(%LedgerEntry{
    description: "credit Fee Revenue 5, debit Dwight Schrute Checking 5",
    date: NaiveDateTime.new!(2024, 4, 18, 0, 0, 0)
  })

_credit_fee_revenue_5_ds =
  Repo.insert!(%Transaction{
    transaction_type: "credit",
    amount: 5.00,
    date: NaiveDateTime.new!(2024, 4, 18, 0, 0, 0),
    account: fee_revenue,
    currency: usd,
    ledger_entry: ds_fee_5
  })

_debit_ds_5 =
  Repo.insert!(%Transaction{
    transaction_type: "debit",
    amount: 5.00,
    date: NaiveDateTime.new!(2024, 4, 18, 0, 0, 0),
    account: dwight_schrute_checking,
    currency: usd,
    ledger_entry: ds_fee_5
  })
