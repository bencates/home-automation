defmodule Window.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  @target Mix.Project.config()[:target]

  use Application

  def start(_type, _args) do
    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Window.Supervisor]
    Supervisor.start_link(children(@target), opts)
  end

  # List all child processes to be supervised
  def children(_target) do
    [
      # Starts a worker by calling: Window.Server.start_link(arg)
      {Window.Server, []},
      {Stepper, Application.get_env(:window, :pins)}
    ]
  end
end