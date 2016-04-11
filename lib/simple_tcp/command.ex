defmodule SimpleTcp.Command do
  @moduledoc """
  Handles all input requests and runs a command
  or casts a message
  """

  def exec(msg, %{room: room, socket: socket} = state) do
    room |> via_tuple |> cast_message(msg, socket)

    state
  end

  defp cast_message(tuple, msg, socket) do
    GenServer.cast(tuple, {:msg, msg, socket})
  end

  def via_tuple(room) do
    {:via, :gproc, tuple_key(room) }
  end

  def tuple_key(room) do
    {:p, :l, {:room, room}}
  end
end
