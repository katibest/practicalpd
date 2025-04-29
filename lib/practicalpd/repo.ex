defmodule Practicalpd.Repo do
  use Ecto.Repo,
    otp_app: :practicalpd,
    adapter: Ecto.Adapters.Postgres
end
