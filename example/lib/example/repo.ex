defmodule Example.Repo do
  use Ecto.Repo,
    otp_app: :example,
    adapter: Ecto.Adapters.Postgres

  use Scrivener, page_size: 10, options: [allow_overflow_page_number: true]
end
