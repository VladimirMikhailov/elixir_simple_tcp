defmodule SimpleTcp.Worker do
  @moduledoc """
    Worker process accepting tcp connections
    in loop and starting sender for each new one.

    Examples:
      iex> SimpleTcp.Worker.start_link(9000)

      # Starts listening on 9000 port
  """
  import Socket

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

    spawn(fn -> init_listener(client) end)

    loop_connection(server)
  end

  defp init_listener(client) do
    {:ok, _pid} = SimpleTcp.Sender.start_link(client)
    listen_for_msg(client)
  end

  defp listen_for_msg(client) do
    case Socket.Stream.recv(client) do
      {:ok, data} ->
        GenServer.cast({:via, :gproc, {:p, :l, :something}}, {:msg, data})
        listen_for_msg(client)
      {:error, :closed} -> :ok
      other -> IO.inspect(other)
    end
  end
end
