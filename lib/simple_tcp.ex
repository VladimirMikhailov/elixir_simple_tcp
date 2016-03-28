defmodule SimpleTcp do
  @moduledoc """
    A Simple TCP serverb built on top of GenServer signals
  """

  use Application

  def start(_type, _args) do
    import Supervisor, Spec, warn: false

    children = [
      worker(SimpleTcp.Worker, [8000])
    ]

    opts = [strategy: :one_for_one, name: SimpleTcp.Supervisor]
    Supervisor.start_link(children, opts)

    IO.puts "Process end"
  end
end
