defmodule OpentelemetryPhoenixchannel do
  @moduledoc """
  Documentation for `OpentelemetryPhoenixchannel`.
  """

  @spec setup() :: :ok
  def setup() do
    OpentelemetryPhoenixchannel.Handler.attach()
  end
end
