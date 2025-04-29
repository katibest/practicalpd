defmodule Practicalpd.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      PracticalpdWeb.Telemetry,
      Practicalpd.Repo,
      {DNSCluster, query: Application.get_env(:practicalpd, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Practicalpd.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Practicalpd.Finch},
      # Start a worker by calling: Practicalpd.Worker.start_link(arg)
      # {Practicalpd.Worker, arg},
      # Start to serve requests, typically the last entry
      PracticalpdWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Practicalpd.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PracticalpdWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
