# SimpleTcp

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add simple_tcp to a list of dependencies in `mix.exs`:

  ```
    [{:simple_tcp, git: "https://github.com/VladimirMikhailov/elixir_simple_tcp.git"}
  ```

  2. Ensure simple_tcp is started:

  ```
  def application do
    [
      extra_applications: [:logger, :simple_tcp]
    ]
  end
  ```

## Run

  1. Run `iex -S mix`

  2. Connect by telnet client: `telnet localhost 8000`

## Commands

  Channels and the app don't store any information and messages get
  spread only to connected clients.

  `/c NEW ROOM` - Connect to a channel
