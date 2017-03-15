
defmodule Actuator do
  @moduledoc """
  Creates a simple actuator which receives output from simple neuron in
  format: {:doesthiswork, output, self_pid}. The final output is sent
  to the iex process, along with the atom - :actuator_firing.
  """
  def start_link do
    threshold = 5
    Task.start_link(fn ->loop(threshold) end)
  end

  defp loop(threshold) do
    receive do
      {:ok, output, metadata} ->
        final = 
          case output do
            output when -1 < output < 0 -> :x1 
            output when -5 < output <= -1 -> :x0
              output when 0 <= output < 2 -> :y1
            _ -> :y0
          end
    send metadata[:self], {:actuator_firing, final, metadata}
    loop(threshold)
    end
  end
end
