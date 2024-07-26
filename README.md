# OpentelemetryPhoenixchannel

Telemetry handler that creates Opentelemetry spans from Phoenix.Channels events.

## Installation

This package can be installed by adding `opentelemetry_phoenixchannel` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:opentelemetry_phoenixchannel, "~> 0.1.0"}
  ]
end
```

## Usage
After installing, setup the handler in your application behaviour before your top-level supervisor starts.

```elixir
def start(_type, _args) do
  OpentelemetryPhoenixchannel.setup()

  children = [
    {Phoenix.PubSub, name: MyApp.PubSub},
    MyAppWeb.Endpoint
  ]

  opts = [strategy: :one_for_one, name: MyStore.Supervisor]
  Supervisor.start_link(children, opts)
end
```

## License
The software is available as open source under the terms of the [MIT License](https://opensource.org/license/MIT).
