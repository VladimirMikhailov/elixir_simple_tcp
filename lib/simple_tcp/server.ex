defmodule SimpleTcp.Server do
  @moduledoc """
  Start loop listening over tcp port
  and creates a new client for every new
  connection
  """

  def start_link(port) do
    pid = spawn_link(fn -> init(port) end)
    {:ok, pid}
  end

  defp init(port) do
    server = Socket.TCP.listen!(port, [packet: :line])
    loop_connection(server)
  end

  defp loop_connection(server) do
    client = Socket.TCP.accept!(server)
    spawn(fn -> init_client(client) end)

    loop_connection(server)
  end

  defp init_client(client) do
    {:ok, _pid} = SimpleTcp.Listener.start_link(client)
  end
end
