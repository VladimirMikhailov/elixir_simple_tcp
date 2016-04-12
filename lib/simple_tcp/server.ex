defmodule SimpleTcp.Server do
  @moduledoc """
  Start loop listening over tcp port
  and creates a new client for every new
  connection
  """

  def accept(port) do
    server = Socket.TCP.listen!(port, [packet: :line])
    loop_connection(server)
  end

  defp loop_connection(server) do
    client = Socket.TCP.accept!(server)
    {:ok, pid} = Task.Supervisor.start_child(SimpleTcp.ClientsSupervisor, fn -> init_client(client) end)
    :ok = :gen_tcp.controlling_process(client, pid)

    loop_connection(server)
  end

  defp init_client(client) do
    SimpleTcp.Listener.start_link(client)
  end
end
