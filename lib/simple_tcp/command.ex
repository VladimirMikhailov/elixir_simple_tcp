defmodule SimpleTcp.Command do
  def exec(msg, %{room: room, socket: socket} = state) do
    room |> via_tuple |> cast_message(msg, socket)

    state
  end

  defp cast_message(tuple, msg, socket) do
    GenServer.cast(tuple, {:msg, msg, socket})
  end

  def via_tuple(room) do
    {:via, :gproc, {:p, :l, {:room, room}}}
  end
end
