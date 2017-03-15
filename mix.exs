defmodule Cubework.Mixfile do
  use Mix.Project

  def project do
    [app: :cubework,
     version: "0.1.0",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  def application do
    [extra_applications: [:logger]]
  end

  defp deps do
    [
      {:graphmath, "~> 1.0.2"},
      {:exmatrix, "~> 0.0.1"},
      {:matrix, "~>0.3.0"},
      {:math, "~> 0.3.0"},
      {:credo, "~> 0.5", only: [:dev, :test]},
      {:plug, "~> 1.0.3"}
    ]
  end
end
