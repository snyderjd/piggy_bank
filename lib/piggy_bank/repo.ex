defmodule PiggyBank.Repo do
  use Ecto.Repo,
    otp_app: :piggy_bank,
    adapter: Ecto.Adapters.Postgres
end
