defmodule Practicalpd.Projects do
  import Ecto.Query
  alias Practicalpd.{Repo, Project}

  def get_first_project do
    Project
    |> first()
    |> Repo.one()
  end
end
