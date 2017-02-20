defmodule Permutations do
  def shuffle(list), do: shuffle(list, length(list))

    def shuffle([], _), do: [[]]
      def shuffle(_,  0), do: [[]]
        def shuffle(list, i) do
            for x <- list, y <- shuffle(list, i-1), do: [x|y]
       end
   end

#credit to sobelevn on stackoverflow
