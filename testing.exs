    cube = [[1,1,1], [1,0,1],[-1,1,-1]]
    in_cube = [[1,1,1],[1,0,1],[1,-1,1]]
    dv_vector =  [0,0,0,0,0]#[Fitness.dv_mag(cube, in_cube, 0), Fitness.dv_mag(cube, in_cube, 1), Fitness.dv_mag(cube, in_cube, 1), 0]
    weights = [Enum.random(100..100)/100, Enum.random(100..100)/100, Enum.random(100..100)/100, Enum.random(0..100)/100, 1]
    {:ok, cortex} = Cortex.start_link
fitness_agent = Agent.start_link(fn -> %{:cube =>cube,
                                        :in_cube => in_cube,
                                        :weights => weights,
                                        :dv_vector => dv_vector,
                                        :new_dv_vector => nil,}
                                    end)
