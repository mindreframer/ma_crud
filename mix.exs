defmodule MaCrud.MixProject do
  use Mix.Project

  @github_url "https://github.com/mindreframer/ma_crud"
  @version "0.1.4"

  def project do
    [
      app: :ma_crud,
      description: "MaCrud - painless CRUD contexts",
      source_url: @github_url,
      version: @version,
      elixir: "~> 1.14",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps(),
      package: package()
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

  defp package do
    [
      files: ~w(lib mix.exs README* CHANGELOG*),
      licenses: ["MIT"],
      links: %{
        "GitHub" => @github_url,
        "CHANGELOG" => "https://github.com/mindreframer/ma_crud/blob/main/CHANGELOG.md"
      }
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
