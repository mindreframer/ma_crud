defmodule Example.MixProject do
  use Mix.Project

  def project do
    [
      app: :example,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Example.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ma_crud, path: ".."},
      {:ecto_sql, ">= 3.0.0"},
      {:postgrex, ">= 0.0.0"}, 
      {:phoenix, ">= 1.7.1"}, 
      {:inflex, "~> 2.0.0"}, 
      {:scrivener_ecto, "~> 2.7"}
      # {:scrivener_ecto, path: "deps/scrivener_ecto"}
    ]
  end
end
