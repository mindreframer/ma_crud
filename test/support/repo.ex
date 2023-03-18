defmodule MaCrud.Repo do
  use Ecto.Repo,
    otp_app: :ma_crud,
    adapter: Ecto.Adapters.Postgres
end
