import Config

# Repos known to Ecto:
config :ma_crud, ecto_repos: [MaCrud.Repo]

# Test Repo settings
config :ma_crud, MaCrud.Repo,
  database: "ma_crud_test",
  hostname: "localhost",
  poolsize: 10,
  # Ensure async testing is possible:
  pool: Ecto.Adapters.SQL.Sandbox

import_config "db_secret.exs"
