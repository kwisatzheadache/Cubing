defmodule Cortex do
  @moduledoc """
  The cortex handles neuron and actuator generation. Additionally, it generates input and
  creates a map of pids for communication.
  """
  def start_link do
    {:ok, pids} = Agent.start_link(fn -> %{} end)
    {:ok, neuron} = Neuron.start_link
    {:ok, actuator} = Actuator.start_link
    self = self()
    #weights = [Enum.random(100..100)/100, Enum.random(100..100)/100, Enum.random(100..100)/100, Enum.random(0..100)/100]
    Agent.update(pids, fn list -> Map.put(list, :neuron, neuron) end)
    Agent.update(pids, fn list -> Map.put(list, :actuator, actuator) end)
    Agent.update(pids, fn list -> Map.put(list, :self, self) end)
    #Agent.update(pids, fn list -> Map.put(list, :weights, weights) end)
    Task.start_link(fn -> loop(pids) end)
  end

  defp loop(pids) do
    receive do
      {:sense, input, weights} ->
        Agent.update(pids, fn list -> Map.put(list, :input, input) end)
        Agent.update(pids, fn list -> Map.put(list, :weights, weights) end)
        metadata = Agent.get(pids, fn list -> list end)
        Sense.input(Agent.get(pids, fn list -> Map.get(list, :neuron) end), metadata)
        send (Agent.get(pids, fn list -> Map.get(list, :self) end)), {:ok, metadata, pids}
        loop(pids)
    end
  end
end
