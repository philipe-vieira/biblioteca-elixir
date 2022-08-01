defmodule Bibl.Repo do
  use Ecto.Repo,
    otp_app: :bibl,
    adapter: Ecto.Adapters.Postgres
end
