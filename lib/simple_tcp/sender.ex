defmodule SimpleTcp.Sender do
  @moduledoc """
  Implements GenServer and and sends
  messages via Erlang's gproc by brodcasting messages
  """
  use GenServer

  def start_link(socket, opts \\ []) do
    GenServer.start_link(__MODULE__, [socket: socket], opts)
  end

  def init(socket) do
    :gproc.reg({:p, :l, :something})
    {:ok, socket}
  end

  def handle_cast({:msg, msg}, [socket: socket] = state) do
    Socket.Stream.send(socket, msg)
    {:noreply, state}
  end
end
