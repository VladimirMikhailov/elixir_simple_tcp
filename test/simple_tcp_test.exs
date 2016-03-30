defmodule SimpleTcpTest do
  use ExUnit.Case
  doctest SimpleTcp

  setup do
    :ok = Application.ensure_started(:simple_tcp)

    {:ok, socket} = :gen_tcp.connect(
      'localhost',
      8000,
      [:binary, packet: :line, active: false]
    )

    {:ok, [socket: socket]}
  end

  test "hearing a brodacasting message", %{socket: socket} do
    :ok = :gen_tcp.send(socket, "Hello, world!\n")

    case :gen_tcp.recv(socket, 0) do
      {:ok, response} ->
        assert response == "Hello, world!\n"
      {:error, reason} ->
        flunk "Did not receive response: #{reason}"
    end

    :ok = :gen_tcp.close(socket)
  end
end
