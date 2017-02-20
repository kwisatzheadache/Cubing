#define rotation matrices
defmodule Rotate do
  def xxx (init) do
     rotX = [[1,0,0],[0,0,-1],[0,1,0]]
     Matrix.mult(init,rotX)
  end

  def yyy (init) do  
    rotY = [[0,0,1],[0,1,0],[-1,0,0]]
    Matrix.mult(init,rotY)
  end
  
  def zzz (init) do
    rotZ = [[0,-1,0],[1,0,0],[0,0,1]]
    Matrix.mult(init,rotZ)
  end
end

    
