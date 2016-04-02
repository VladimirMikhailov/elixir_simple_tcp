defmodule SimpleTcpTest do
  use ExUnit.Case
  doctest SimpleTcp

  setup do
    :ok = Application.ensure_started(:simple_tcp)
    opts = [:binary, packet: :line, active: false]

    {:ok, sender} = :gen_tcp.connect('localhost', 8000, opts)
    {:ok, receiver} = :gen_tcp.connect('localhost', 8000, opts)

    {:ok, [sender: sender, receiver: receiver]}
  end

  @tag timeout: 500
  test "hearing a brodacasting message",
    %{sender: sender, receiver: receiver} do

    :ok = :gen_tcp.send(sender, "Hello, world!\n")

    case :gen_tcp.recv(receiver, 0) do
      {:ok, response} ->
        assert response == "Hello, world!\n"
      {:error, reason} ->
        flunk "Did not receive response: #{reason}"
    end
  end
end
