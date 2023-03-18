{:ok, _pid} = MaCrud.Repo.start_link()
Ecto.Adapters.SQL.Sandbox.mode(MaCrud.Repo, :manual)
ExUnit.start()
