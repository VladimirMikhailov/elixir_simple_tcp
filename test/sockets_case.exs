defmodule SocketsCase do
  use ExUnit.CaseTemplate

  setup_all do
    sender = init_socket
    receiver = init_socket

    on_exit fn ->
      :gen_tcp.close(sender)
      :gen_tcp.close(receiver)
    end

    {:ok, [sender: sender, receiver: receiver]}
  end

  defp init_socket do
    opts = [:binary, packet: :line, active: false]
    {:ok, socket} = :gen_tcp.connect('localhost', 8000, opts)
    {:ok, "You're entered default channel\n"} = :gen_tcp.recv(socket, 0)

    socket
  end
end
