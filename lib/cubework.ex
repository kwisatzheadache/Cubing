# This is a module to manipulate a hypothetical rubix cube.
# First, we must decide how to conceptualize the cube.
# I have chosen to represent each colored block individually,
# giving them XYZ coordinates, ranging from -1 to 1. Thus,
# each of the 27 pieces of the cube is represented by a vector,
# which allows us to rotate the pieces according to simple rotation
# matrices. Since the rotations will always be 90 degrees, we can
# simplify the rotation matrices and remove sin(angle)/cos(angle).


defmodule Cubing do
    # The rotation matrix is used to transform the blocks, the
    # index selects the blocks to which the rotation matrix is applied.
  def rotate(cube, axis, position) do
       {matrix, index} = 
      case axis do
        :x -> {[[1,0,0],
               [0,0,-1],
               [0,1,0]],0}
        :y -> {[[0,0,1],
               [0,1,0],
               [-1,0,0]],1}
        :z -> {[[0,-1,0],
               [1,0,0],
               [0,0,1]],2}
      end


      # The entire cube is passed through and the blocks are
      # selected based on whether they have the correct index.
      # The selected vectors are transformed via the rotation matrix
      # and the non-selected vectors pass through unchanged.
    Enum.map(cube, fn(input) ->
     if Enum.at(input, index) == position do 
          List.flatten(Matrix.mult([input], matrix))
      else
          input
      end
    end)
  end


    # This is a recursive function to shuffle the cube. Each
    # iteration, a new axis and index is created, which is then passed
    # to the Cubing.rotate function above. At each iteration, the new
    # set of vectors is stored in as a new variable called new_cube
  def shuffle(cube, iterations) when iterations <= 1 do
       axisprob = Enum.random(-1..1)
       position = Enum.random(-1..1)
       {axis} = 
          case axisprob do
            -1 -> {:x}
            0  -> {:y}
            1  -> {:z}
          end
       Cubing.rotate(cube,axis,position)
  end

  def shuffle(cube, iterations) do
       axisprob = Enum.random(-1..1)
       position = Enum.random(-1..1)
       {axis} = 
          case axisprob do
            -1 -> {:x}
            0  -> {:y}
            1  -> {:z}
          end
       transformation = {axis, position}
       IO.inspect transformation
       new_cube = Cubing.rotate(cube,axis,position)
       Cubing.shuffle(new_cube, iterations - 1)
    end
end

# credit to sobelevn on stackoverflow
defmodule Cubing.Permutations do
  def shuffle(list), do: shuffle(list, length(list))
  def shuffle([], _), do: [[]]
  def shuffle(_,  0), do: [[]]
  def shuffle(list, i) do
    for x <- list, y <- shuffle(list, i-1), do: [x|y]
  end
end


# Module to attempt some sort of fitness determination.
# Diff_vector is the difference between the vector in position x of the cube before/after shuffle
# diff_mag is the weight, the length of the vector
# the sum of these weights is potentially useful in determining fitness
defmodule Fitness do
  def dv_mag(cube, shuffled, listposition) do
    diff_vector = List.flatten(Matrix.sub([Enum.at(cube, listposition)], [Enum.at(shuffled,listposition)]))
    diff_mag = Math.sqrt(Enum.sum(Enum.map(diff_vector, fn(x) -> x*x end)))
  end

# Recursive function to find the sum of the diff_mag's
# There's a better way to do this I'm sure, but this will work for now.

  def total(cube, shuffled, acc, counter) when counter < 26 do
    fit = acc + Fitness.dv_mag(cube, shuffled, counter)
    nextit = counter + 1
    Fitness.total(cube, shuffled, fit, nextit)
  end

  def total(cube, shuffled, acc, counter) do
    fit = acc + Fitness.dv_mag(cube, shuffled, counter)
    IO.inspect fit
  end
end

# The problem now is there there is relatively little variance in possible
# fitness totals. I'll have to look into whether it will be useful or not.
