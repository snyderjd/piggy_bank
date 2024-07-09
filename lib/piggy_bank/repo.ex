defmodule PiggyBank.Repo do
  use Ecto.Repo,
    otp_app: :piggy_bank,
    adapter: Ecto.Adapters.Postgres

  use Scrivener, page_size: 10
end
