defmodule Neuron do
  @moduledoc """
  Creates a simple neuron, with 2 random weights and a random bias.
  Neuron receives input vector of length 3, generates Weight*input
  dot product. Arbitrary activation function is applied to the dot
  product, which produces a final output, which is sent to corresponding
  actuator.
  Must be sure to use the following send
  send neuron, {:ok, self(), neuron_pid, actuator_pid, input_vector}
  """


  def start_link do
    #weights = [w1, w2, w3, bias]
    Task.start_link(fn -> loop(1) end)
  end

  defp loop(1) do
    receive do
      {:ok, metadata} -> 
        dot_product = Vector.dot_product(metadata[:input], metadata[:weights])
        output = :math.tanh(dot_product)
      send metadata[:actuator], {:ok, output, metadata}
      loop(1)
    end
  end
end
