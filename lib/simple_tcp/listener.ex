defmodule SimpleTcp.Listener do
  @moduledoc """
  Modules listening for all incoming inputs
  and casts inputs to all clients
  """

  @channel "default"

  def start_link(socket) do
    {:ok, _pid} = SimpleTcp.Client.start_link(%{socket: socket, channel: @channel})
    pid = spawn_link(fn -> listen_for_msg(%{socket: socket, channel: @channel}) end)

    {:ok, pid}
  end

  defp listen_for_msg(%{socket: socket} = state) do
    case Socket.Stream.recv(socket) do
      {:ok, data} ->
        data |> cast_message(state) |> listen_for_msg
      {:error, :closed} -> :ok
      _ -> Socket.Stream.close(socket)
    end
  end

  defp cast_message(data, state) do
    SimpleTcp.Command.exec(data, state)
  end
end
