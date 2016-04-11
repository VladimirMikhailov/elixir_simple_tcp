defmodule SocketsCase do
  use ExUnit.CaseTemplate

  setup_all do
    opts = [:binary, packet: :line, active: false]

    {:ok, sender} = :gen_tcp.connect('localhost', 8000, opts)
    {:ok, receiver} = :gen_tcp.connect('localhost', 8000, opts)

    on_exit fn ->
      :gen_tcp.close(sender)
      :gen_tcp.close(receiver)
    end

    {:ok, [sender: sender, receiver: receiver]}
  end
end
