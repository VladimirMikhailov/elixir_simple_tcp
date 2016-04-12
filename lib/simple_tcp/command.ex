defmodule SimpleTcp.Command do
  @moduledoc """
  Handles all input requests and runs a command
  or casts a message

  Available commands are:
    /c ROOM_NAME - Connect to a new channel name
  """

  @commands %{connect: ~r/\A\/c\s(?<channel>.+)\r/u}

  import SimpleTcp.Cast, only: [via_tuple: 1]

  def exec(nil, state), do: state
  def exec(msg, %{channel: channel} = state) do
    channel |> via_tuple |> perform(msg, state)
  end

  defp perform(tuple, msg, state) do
    case command_expression(msg) do
      {command, expression} ->
        apply(__MODULE__, command, [tuple, Regex.named_captures(expression, msg), state])

      _other ->
        cast_message(tuple, msg, state)
    end
  end

  defp cast_message(tuple, msg, %{socket: socket} = state) do
    GenServer.cast(tuple, {:msg, msg, socket}) && state
  end

  def connect(tuple, %{"channel" => channel}, %{socket: socket} = state) do
    GenServer.cast(tuple, {:reconnect, channel, socket})
    %{state | channel: channel}
  end

  defp command_expression(msg) do
    Enum.find(@commands, fn {_, expression} -> Regex.named_captures(expression, msg) end)
  end
end
