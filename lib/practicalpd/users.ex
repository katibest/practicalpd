defmodule Practicalpd.Users do
  import Ecto.Query
  alias Practicalpd.{Repo, User}

  def list_users do
    User
    |> order_by([u], u.name)
    |> Repo.all()
  end
end
