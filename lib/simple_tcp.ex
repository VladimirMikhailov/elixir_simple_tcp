defmodule SimpleTcp do
  @moduledoc """
  Start a worker process and attach the Supervisor
  """

  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(SimpleTcp.Server, [8000])
    ]

    opts = [strategy: :one_for_one, name: SimpleTcp.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
