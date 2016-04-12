defmodule SimpleTcp.Cast do
  @moduledoc """
    Helper methods for interacting with process
    through genserver using gproc
  """

  def via_tuple(room) do
    {:via, :gproc, tuple_key(room) }
  end

  def tuple_key(room) do
    {:p, :l, {:room, room}}
  end
end
