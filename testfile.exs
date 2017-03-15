{:ok, fitness, metadata} = Trainer.begin(cubeslice, in_cube)

Trainer.evolve(cubeslice, in_cube, fitness, metadata, 10)

flush()
