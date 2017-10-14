defmodule SimpleTcpTest do
  use SocketsCase
  doctest SimpleTcp

  setup %{sender: sender} do
    :ok = :gen_tcp.send(sender, "Hello, world!\n")
  end

  test "handle cast for same socket", %{sender: sender} do
    listen_message(self(), sender)

    assert_received({:error, :timeout})
  end

  test "hearing a brodacasting message", %{receiver: receiver} do
    listen_message(self(), receiver)

    assert_received({:ok, "Hello, world!\n"})
  end

  defp listen_message(caller, socket) do
    case :gen_tcp.recv(socket, 0, 10) do
      any -> send(caller, any)
    end
  end
end
