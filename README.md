# Cubework
This is my Elixir learning project. The end goal is to build a neural net 
capable of solving a rubix cube. I've broken the process down as follows:

1.Creation of the cube

2.Establishing the rotation functions

3.Shuffling the cube

4.Creating fitness function 
  Fitness = 1/(sum of the scalars of the vector difference between the 
    expected coordinates and the solution coordinates.)



I'm nowhere near starting the neural net bits, but I'll get there.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `cubework` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:cubework, "~> 0.1.0"}]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/cubework](https://hexdocs.pm/cubework).

