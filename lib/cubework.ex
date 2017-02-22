defmodule Cubework do
end

defmodule Cubework.Rotate do
  @moduledoc """
  This defines the matrices to rotate the cube around each axis.
  The next step will be to create a function to apply the appropriate Rotate.axis
  to all blocks where, for example, x = -1.
  """

  @doc """
  Define rotation matrices.
  """
  def xxx(init) do
     rot_x = [[1,0,0], [0,0,-1], [0,1,0]]
     Matrix.mult(init,rot_x)
  end

  def yyy(init) do
    rot_y = [[0,0,1], [0,1,0], [-1,0,0]]
    Matrix.mult(init,rot_y)
  end

  def zzz(init) do
    rot_z = [[0,-1,0], [1,0,0], [0,0,1]]
    Matrix.mult(init,rot_z)
  end
end

# credit to sobelevn on stackoverflow
defmodule Cubework.Permutations do
  def shuffle(list), do: shuffle(list, length(list))

  def shuffle([], _), do: [[]]
  def shuffle(_,  0), do: [[]]
  def shuffle(list, i) do
    for x <- list, y <- shuffle(list, i-1), do: [x|y]
  end
end

#Create conditionals to apply rotations only to Axis = x

#Function to apply rotation to vectors, according to Axis = value

defmodule Cubework.Apply do

#### Rotation around X axis
  def xa(input) do
    if Enum.at(input,0)==-1 do
       Cubework.Rotate.xxx([input])
    end
  end
  def xb(input) do
    if Enum.at(input,0)==0 do
       Cubework.Rotate.xxx([input])
    end
  end
  def xc(input) do
    if Enum.at(input,0)==1 do
       Cubework.Rotate.xxx([input])
    end
  end

#### Rotation around Y axis
  def ya(input) do
    if Enum.at(input,1)==-1 do
      Cubework.Rotate.yyy([input])
    end
  end
  def yb(input) do
    if Enum.at(input,1)==0 do
      Cubework.Rotate.yyy([input])
    end
  end
  def yc(input) do
    if Enum.at(input,1)==1 do
      Cubework.Rotate.yyy([input])
    end
  end
#### Rotation around Z axis
  def za(input) do
    if Enum.at(input,2)==-1 do
      Cubework.Rotate.zzz([input])
    end
  end
  def zb(input) do
    if Enum.at(input,2)==0 do
      Cubework.Rotate.zzz([input])
    end
  end
  def zc(input) do
    if Enum.at(input,2)==1 do
      Cubework.Rotate.zzz([input])
    end
  end
end

#Now we need to feed a list of vectors(3) through the previous function, such that
#out of 27 vectors, each of the functions above only act on 9 vectors (like an
#actual rubix cube rotation.
