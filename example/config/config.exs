import Config

config :example, ecto_repos: [Example.Repo]

config :example, Example.Repo,
  database: "ma_crud_example",
  hostname: "localhost",
  username: "postgres",
  password: "postgres",
  poolsize: 10
