# This is a module to manipulate a hypothetical rubix cube.
# First, we must decide how to conceptualize the cube.
# I have chosen to represent each colored block individually,
# giving them XYZ coordinates, ranging from -1 to 1. Thus,
# each of the 27 pieces of the cube is represented by a vector,
# which allows us to rotate the pieces according to simple rotation
# matrices. Since the rotations will always be 90 degrees, we can
# simplify the rotation matrices and remove sin(angle)/cos(angle).


defmodule Cubing do
  def rotate(cube, axis, position) do
    {matrix, index} = #define the rotation matrix, as well as providing a reference point, to be called by Enum.at and apply the rotation matrix to only the appropriate blocks.
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
    Enum.map(cube, fn(input) -> if Enum.at(input, index) == position do #passes each block through the function - if a block's x, y, or z coordinate matches the selected axis value, it passes through
    end
     List.flatten(Matrix.mult([input], matrix)) #apply the rotation matrices to the appropriate blocks
      else
       input # otherwise, returns the original value. In a given rotation, only 9 blocks will be transformed, while 18 values will be returned the same.
      end
      end)
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

