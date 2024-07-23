defmodule OpentelemetryPhoenixchannel.Handler do
  require OpenTelemetry.Tracer
  alias OpenTelemetry.Tracer

  @tracer_id __MODULE__

  def attach() do
    :telemetry.attach(
      {__MODULE__, [:phoenix, :channel_joined]},
      [:phoenix, :channel_joined],
      &__MODULE__.handle_channel_joined/4,
      []
    )

    :telemetry.attach(
      {__MODULE__, [:phoenix, :channel_handled_in]},
      [:phoenix, :channel_handled_in],
      &__MODULE__.handle_channel_handled_in/4,
      []
    )
  end

  def handle_channel_joined(
        _event,
        %{duration: duration},
        %{socket: socket, result: :ok} = metadata,
        _config
      ) do
    OpentelemetryTelemetry.start_telemetry_span(
      @tracer_id,
      "phoenix.channel_joined #{socket.channel}",
      metadata,
      %{
        kind: :server
      }
    )

    OpentelemetryTelemetry.set_current_telemetry_span(@tracer_id, metadata)
    Tracer.set_attribute("duration", duration)
    OpentelemetryTelemetry.end_telemetry_span(@tracer_id, metadata)
  end

  def handle_channel_joined(
        _event,
        %{duration: duration},
        %{socket: socket, result: result} = metadata,
        _config
      ) do
    OpentelemetryTelemetry.start_telemetry_span(
      @tracer_id,
      "phoenix.channel_joined #{socket.channel}",
      metadata,
      %{
        kind: :server
      }
    )

    OpentelemetryTelemetry.set_current_telemetry_span(@tracer_id, metadata)
    Tracer.set_attribute("duration", duration)
    status = OpenTelemetry.status(:error, "Failed to join channel: #{result}")
    Tracer.set_status(status)
    OpentelemetryTelemetry.end_telemetry_span(@tracer_id, metadata)
  end

  def handle_channel_handled_in(
        _event,
        %{duration: duration},
        %{socket: socket} = metadata,
        _config
      ) do
    OpentelemetryTelemetry.start_telemetry_span(
      @tracer_id,
      "phoenix.handled_in #{socket.channel}",
      metadata,
      %{
        kind: :server
      }
    )

    OpentelemetryTelemetry.set_current_telemetry_span(@tracer_id, metadata)
    Tracer.set_attribute("duration", duration)
    OpentelemetryTelemetry.end_telemetry_span(@tracer_id, metadata)
  end
end
