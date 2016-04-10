defmodule SimpleTcp.Listener do
  @moduledoc """
  Modules listening for all incoming inputs
  and casts inputs to all clients
  """

  def start_link(socket) do
    pid = spawn_link(fn -> listen_for_msg(socket) end)
    {:ok, pid}
  end

  defp cast_message(msg) do
    GenServer.cast({:via, :gproc, {:p, :l, :something}}, msg)
  end

  defp listen_for_msg(socket) do
    case Socket.Stream.recv(socket) do
      {:ok, data} ->
        cast_message({:msg, data, socket})
        listen_for_msg(socket)
      {:error, :closed} -> :ok
      _ -> Socket.Stream.close(socket)
    end
  end
end
