defmodule SimpleTcp.Cast do
  @moduledoc """
    Helper methods for interacting with process
    through genserver using gproc
  """

  def via_tuple(channel) do
    {:via, :gproc, tuple_key(channel) }
  end

  def tuple_key(channel) do
    {:p, :l, {:channel, channel}}
  end
end
