defmodule MaCrud.MixProject do
  use Mix.Project

  def project do
    [
      app: :ma_crud,
      version: "0.1.0",
      elixir: "~> 1.14",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      deps: deps(), 
      aliases: aliases(), 

    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  def elixirc_paths(:test), do: ["lib", "test/support"]
  def elixirc_paths(_), do: ["lib"]

  defp aliases do
    [
      test: ["ecto.create --quiet", "ecto.migrate", "test"]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      
      {:ecto, ">= 3.0.0"},
      {:gettext, ">= 0.0.0"},
      {:ecto_sql, ">= 3.0.0", only: :test},
      {:postgrex, ">= 0.0.0", only: :test},
      {:excoveralls, "~> 0.11", only: :test},
      {:ex_doc, "~> 0.29", only: :dev, runtime: false},
      {:test_iex, github: "mindreframer/test_iex", only: :test}
    ]
  end
end
