defmodule OpentelemetryPhoenixchannel do
  @moduledoc """
  OpentelemetryPhoenixchannel uses [telemetry](https://hexdocs.pm/telemetry/) handlers to create `OpenTelemetry` spans for `Phoenix.Channels`.

  Current events which are supported include channel join and handle_in events.

  ## Usage
  In your application start:

      def start(_type, _args) do
        OpentelemetryPhoenixchannel.setup()

        children = [
          {Phoenix.PubSub, name: MyApp.PubSub},
          MyAppWeb.Endpoint
        ]

        opts = [strategy: :one_for_one, name: MyStore.Supervisor]
        Supervisor.start_link(children, opts)
      end
  """

  @doc """
  Initializes and configures the telemetry handlers.
  """
  @spec setup() :: :ok
  def setup() do
    OpentelemetryPhoenixchannel.Handler.attach()
  end
end
