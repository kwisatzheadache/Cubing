defmodule Trainer do
  def begin do
    #create NN 
    cube = [[1,1,1], [1,0,1],[-1,1,-1]]
    in_cube = [[1,1,1],[1,0,1],[1,-1,1]]
    dv_vector =  [0,0,0,0,0]#[Fitness.dv_mag(cube, in_cube, 0), Fitness.dv_mag(cube, in_cube, 1), Fitness.dv_mag(cube, in_cube, 1), 0]
    weights = [Enum.random(100..100)/100, Enum.random(100..100)/100, Enum.random(100..100)/100, Enum.random(0..100)/100, 1]
    {:ok, cortex} = Cortex.start_link
    #input is dv_vector from cube
    #initial cubeslice is list, such that Cubing.rotate(cube, :x, 1) will return blocks to their
    #"appropriate" position, thus yielding a dv_vector of 0 and a perfect fitness value...
    #fitness is sum of dv values
    #first sense cascade to neuron
    # fitness_agent = Agent.start_link(fn -> %{:cube =>cube,
    #                                          :in_cube => in_cube,
    #                                          :weights => weights,
    #                                          :dv_vector => dv_vector,
    #                                          :new_dv_vector => nil,}
    #                                 end)
    send cortex, {:sense, dv_vector, weights}
    receive do
      {:actuator_firing, output, metadata} ->
        rotation = 
        case output do
          :x_is_0 ->  %{:cube => in_cube, :axis => :x, :index => 1}
          :x_is_1 ->  %{:cube => in_cube, :axis => :x, :index => 1}
        end
      new_cube = Cubing.rotate(in_cube, rotation[:axis], rotation[:index])  
      new_dv_vector =  [Fitness.dv_mag(cube, new_cube, 0), Fitness.dv_mag(cube, new_cube, 1), Fitness.dv_mag(cube, new_cube, 1), 0]
      fitness = Enum.sum(new_dv_vector)
      #Agent.update(fitness_agent, fn map -> Map.put(map, :fitness, fitness) end)
      send metadata[:self], {:ok, fitness}#Agent.get(fitness_agent, fn map -> map end)}
    end
  end
end
