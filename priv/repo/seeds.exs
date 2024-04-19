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

@doc """
Need to insert some seed data to get up and running

users
currencies
account_types
accounts
ledger_entries
transactions
"""

# Bcrypt.hash_pwd_salt("password123")
# "$2b$12$ezayYzr2qcPUiGCXmhvjG.I6Y0Y1fP32WDY9xac4F5HzVq7daO4I2"
# users
warren_buffett = Repo.insert!(%User{
  name: "Warren Buffett",
  email: "warren.buffett@testuser.com",
  password: "$2b$12$ezayYzr2qcPUiGCXmhvjG.I6Y0Y1fP32WDY9xac4F5HzVq7daO4I2"
})

dwight_schrute = Repo.insert!(%User{
  name: "Dwight Schrute",
  email: "dwight.schrute@testuser.com",
  password: "$2b$12$ezayYzr2qcPUiGCXmhvjG.I6Y0Y1fP32WDY9xac4F5HzVq7daO4I2"
})

# currencies
usd = Repo.insert!(%Currency{name: "US Dollar", code: "USD"})
eur = Repo.insert!(%Currency{name: "Euro", code: "EUR"})
gpb = Repo.insert!(%Currency{name: "British Pound", code: "GBP"})

# account_types
asset = Repo.insert!(%AccountType{name: "Asset"})
liability = Repo.insert!(%AccountType{name: "Liability"})
equity = Repo.insert!(%AccountType{name: "Equity"})
revenue = Repo.insert!(%AccountType{name: "Revenue"})
expense = Repo.insert!(%AccountType{name: "Expense"})

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

fee_revenue = Repo.insert!(%Account{name: "Fee Revenue", usd_current_balance: 0, account_type: revenue})

# transactions + ledger_entries
# Warren Buffett deposits 1_000
# Warren Buffett withdraws 250
# Warren Buffett transfers 100 to Dwight Schrute
# Charge $5 fee to Warren Buffett
# Charge $5 fee to Dwight Schrute

# ledger_entries
