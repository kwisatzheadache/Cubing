defmodule Sense do
  @moduledoc """
  typically called by the cortex via:
  send cortex, {:sense}
  or
  send cortex, {:feedback}

  The Cortex.start_link command generates metadata
  containing pids and input.
  """
  def input(neuron, metadata) do
    send neuron,  {:ok, metadata}
  end
end
