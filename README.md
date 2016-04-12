# SimpleTcp

[![Build
Status](https://semaphoreci.com/api/v1/VladimirMikhailov/elixir_simple_tcp/branches/master/badge.svg)](https://semaphoreci.com/VladimirMikhailov/elixir_simple_tcp)

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add simple_tcp to your list of dependencies in `mix.exs`:

        def deps do
          [{:simple_tcp, git: "https://github.com/VladimirMikhailov/elixir_simple_tcp.git"}]
        end

  2. Ensure simple_tcp is started before your application:

        def application do
          [applications: [:simple_tcp]]
        end

## Run

  1. Run `iex -S mix`

  2. Use telnet clients: `telnet localhost 8000`

## Commands

  `/c NEW ROOM` - you can reconnect to another channel. Channels don't
  accumulate your messages and it's should be connected client to hear
  your messages
