# Cubework

This is my Elixir learning project. The end goal is to build a neural net
capable of solving a rubix cube. I've broken the process down as follows:

1. Creation of the cube

2. Establishing the rotation functions

3. Shuffling the cube

4. Creating fitness function
  Fitness = 1/(sum of the scalars of the vector difference between the
    expected coordinates and the solution coordinates.)

5. Learn Neural Nets

6. Make them.

So far, I've got a functioning cube module and a single neuron NN that
doesn't quite train properly. However, if you want to check it out, 
pull the repository and run the following:

```
mix deps.get

mix compile

iex -S mix
```

``` elixir
iex(1)> {:ok, fitness, metadata} = Trainer.begin(cubeslice, in_cube)

Trainer.evolve(cubeslice, in_cube, fitness, metadata, 10)

flush()
```


This will take a slice of the rubix cube and run it through the NN. The NN 
determine which direction to rotate it. The NN is trained according to the 
correctness of the cubeslice after the rotation.

Unfortunately, the NN isn't training properly. I suspect the following:
1. Since I cobbled the NN/rubix chimera together with the sole intention
of achieving an executable sequence, I paid less mind to cleanliness and 
process organization. Consequently, the metadata is generated in the cortex
but the training module (tries to) updates it. Upon examining the flush()
output, I've concluded that there is a syncing problem such that the pid 
for the metadata agent is different between the cortex and the training 
modules. When I redesign the NN, I'll have to separate the metadata creation
so that it is an independent process and can be updated from any other process
with less trouble. 

2. This is a single neuron that was primarily a learning exercise. I didn't
feel comfortable jumping into the available NN libraries if I didn't understand
the basics first. Now that I know the basics, I'll be moving to creating 
neurons in layers, etc. All that fancy stuff.

3. The learning algorithm would have worked, I think. The output showed that 
the weights were changing with each iteration, and the fitness of the initial
slice is worse than the first iteration. As such, I think once the 
communication/metadata issue is resolved, it will train properly.

4. Obvious formatting issues and consistency.
