defmodule Trainer do
  def begin(cubeslice, in_cube) do
    dv_vector =  [Fitness.dv_mag(cubeslice, in_cube, 0), Fitness.dv_mag(cubeslice, in_cube, 1), Fitness.dv_mag(cubeslice, in_cube, 2), 0]
    weights = [Enum.random(0..100)/100, Enum.random(0..100)/100, Enum.random(0..100)/100, Enum.random(0..100)/100]
    {:ok, cortex} = Cortex.start_link

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
          :x0 ->  %{:cube => in_cube, :axis => :x, :index => 1}
          :x1 ->  %{:cube => in_cube, :axis => :x, :index => 1}
          :y0 ->  %{:cube => in_cube, :axis => :y, :index => 1}
          :y1 ->  %{:cube => in_cube, :axis => :y, :index => 1}
        end
      new_cube = Cubing.rotate(in_cube, rotation[:axis], rotation[:index])  
      new_dv_vector =  [Fitness.dv_mag(cubeslice, new_cube, 0), Fitness.dv_mag(cubeslice, new_cube, 1), Fitness.dv_mag(cubeslice, new_cube, 1), 0]
      fitness = Enum.sum(new_dv_vector)
      metadata = Map.put(metadata, :new_cube, new_cube)
      #Agent.update(fitness_agent, fn map -> Map.put(map, :fitness, fitness) end)
      send metadata[:self], {:ok, fitness, metadata}#Agent.get(fitness_agent, fn map -> map end)}
      end
  end

  def iterate(cubeslice, in_cube, metadata) do
    dv_vector =  [Fitness.dv_mag(cubeslice, in_cube, 0), Fitness.dv_mag(cubeslice, in_cube, 1), Fitness.dv_mag(cubeslice, in_cube, 2), 0]
    weights = Map.get(metadata, :weights)
    new_weights = [(Enum.at(weights,0) + Enum.random(-100..100)/100), (Enum.at(weights,1) + Enum.random(-100..100)/100), (Enum.at(weights,2) + Enum.random(-100..100)/100), 0]
    {:ok, cortex} = Cortex.start_link
    send cortex, {:sense, dv_vector, new_weights}
    receive do
      {:actuator_firing, output, metadata} ->
        rotation = 
        case output do
            :x0 ->  %{:cube => in_cube, :axis => :x, :index => 1}
            :x1 ->  %{:cube => in_cube, :axis => :x, :index => 1}
            :y0 ->  %{:cube => in_cube, :axis => :y, :index => 1}
            :y1 ->  %{:cube => in_cube, :axis => :y, :index => 1}
        end
      new_cube = Cubing.rotate(in_cube, rotation[:axis], rotation[:index])  
      new_dv_vector =  [Fitness.dv_mag(cubeslice, new_cube, 0), Fitness.dv_mag(cubeslice, new_cube, 1), Fitness.dv_mag(cubeslice, new_cube, 1), 0]
      fitness = Enum.sum(new_dv_vector)
      metadata = Map.put(metadata, :new_cube, new_cube)
      Agent.update(Map.get(metadata, :agent), fn list -> Map.put(list, :fitness, fitness) end)
      send metadata[:self], {:ok, fitness, metadata}
    end
end
  
def evolve(cubeslice, in_cube, fitness_initial, meta, iterations) when iterations > 1 do
    new_iterations = iterations - 1
    {:ok, new_fitness, new_meta} = Trainer.iterate(cubeslice, in_cube, meta)
    delta = fitness_initial - new_fitness
    if delta > 0 do
      #{:ok, newest_fitness, newest_meta} = Trainer.iterate(cubeslice, in_cube, meta)
      send self(),{:ok, delta}
      Trainer.evolve(cubeslice, in_cube, new_fitness, new_meta, new_iterations)
    else
      #{:ok, new_fitness, new_meta} = Trainer.iterate(cubeslice, in_cube, meta)
      Trainer.evolve(cubeslice, in_cube, fitness_initial, meta, new_iterations)
    end
end

def evolve(cubeslice, in_cube, fitness, meta, iterations) do
    send self(), {:ok, "Good job, you're done."}
end
end
