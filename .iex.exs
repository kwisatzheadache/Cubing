[a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,zz] = Cubing.Permutations.shuffle [-1,0,1]
cube = [a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,zz] 

cubeslice = [[1,1,1], [1,0,1],[-1,1,-1]]
in_cube = [[1,1,1],[1,0,1],[1,-1,1]]
dv_vector =  [0,0,0,0,0]
weights = [Enum.random(100..100)/100, Enum.random(100..100)/100, Enum.random(100..100)/100, Enum.random(0..100)/100, 1]
{:ok, cortex} = Cortex.start_link
fitness_agent = Agent.start_link(fn -> %{:cube =>cubeslice,
                                        :in_cube => in_cube,
                                        :weights => weights,
                                        :dv_vector => dv_vector,
                                        :new_dv_vector => nil,}
                                    end)
