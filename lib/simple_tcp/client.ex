defmodule SimpleTcp.Client do
  @moduledoc """
  Handles cast messages sent from mates.
  """
  use GenServer

  def start_link(socket, opts \\ []) do
    GenServer.start_link(__MODULE__, [socket: socket], opts)
  end

  def init([socket: socket] = state) do
    :gproc.reg({:p, :l, :something})
    {:ok, _pid} = SimpleTcp.Listener.start_link(socket)

    {:ok, state}
  end

  def handle_cast({:msg, _msg, socket}, [socket: socket] = state) do
    {:noreply, state}
  end

  def handle_cast({:msg, msg, _}, [socket: socket] = state) do
    Socket.Stream.send(socket, msg)
    {:noreply, state}
  end
end
