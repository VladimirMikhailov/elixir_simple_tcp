defmodule SimpleTcp.Client do
  @moduledoc """
  Handles cast messages sent from mates.
  """
  use GenServer
  import SimpleTcp.Cast, only: [tuple_key: 1]

  def start_link(state) do
    GenServer.start_link(__MODULE__, state)
  end

  def init(%{room: room} = state) do
    room |> tuple_key |> :gproc.reg
    {:ok, state}
  end

  def handle_cast({:reconnect, room, socket}, %{socket: socket} = state) do
    spawn(fn -> SimpleTcp.Client.start_link(%{state | room: room}) end)
    {:stop, "Left a room", state}
  end

  def handle_cast({:reconnect, _room, _socket}, state) do
    {:noreply, state}
  end

  def handle_cast({:msg, _msg, socket}, %{socket: socket} = state) do
    {:noreply, state}
  end

  def handle_cast({:msg, msg, _}, %{socket: socket} = state) do
    Socket.Stream.send(socket, msg)
    {:noreply, state}
  end
end
