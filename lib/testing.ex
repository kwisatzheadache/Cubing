#Just playing around with processes and getting them to communicate.
defmodule KV do
  def start_link do
    Task.start_link(fn -> loop(%{}) end)
  end

  defp loop(map) do
    receive do
      {:get, key, caller} ->
        send caller, Map.get(map, key)
        loop(map)
      {:put, key, value} ->
        loop(Map.put(map, key, value))
    end
  end
end

defmodule Add do
  def start_link do
    Task.start_link(fn -> fun() end)
  end

  defp fun() do
    receive do
      {:add3, caller} ->
        send caller, :hellomichael 
        fun()
      {:mult3, caller} ->
        send caller, :goodbyemichael 
        fun()
    end
  end
end

