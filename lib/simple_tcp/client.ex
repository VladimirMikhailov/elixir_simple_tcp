defmodule SimpleTcp.Client do
  @moduledoc """
  Handles cast messages sent from mates.
  """
  use GenServer
  import SimpleTcp.Cast, only: [tuple_key: 1]

  def start_link(state) do
    GenServer.start_link(__MODULE__, state)
  end

  def init(%{channel: channel, socket: socket} = state) do
    channel |> tuple_key |> :gproc.reg
    Socket.Stream.send(socket, "You're entered #{channel} channel\n")

    {:ok, state}
  end

  def handle_cast({:reconnect, channel, socket}, %{socket: socket} = state) do
    spawn(fn -> SimpleTcp.Client.start_link(%{state | channel: channel}) end)
    {:stop, "Left a channel", state}
  end

  def handle_cast({:reconnect, _channel, _socket}, state) do
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
