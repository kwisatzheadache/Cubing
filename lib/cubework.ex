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
     rotX = [[1,0,0], [0,0,-1], [0,1,0]]
     Matrix.mult(init,rotX)
  end

  def yyy(init) do
    rotY = [[0,0,1], [0,1,0], [-1,0,0]]
    Matrix.mult(init,rotY)
  end

  def zzz(init) do
    rotZ = [[0,-1,0], [1,0,0], [0,0,1]]
    Matrix.mult(init,rotZ)
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
