defmodule PiggyBank.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      PiggyBankWeb.Telemetry,
      PiggyBank.Repo,
      {DNSCluster, query: Application.get_env(:piggy_bank, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: PiggyBank.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: PiggyBank.Finch},
      # Start a worker by calling: PiggyBank.Worker.start_link(arg)
      # {PiggyBank.Worker, arg},
      # Start to serve requests, typically the last entry
      PiggyBankWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PiggyBank.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PiggyBankWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
