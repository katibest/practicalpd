defmodule Practicalpd.ProjectUser do
  use Ecto.Schema
  import Ecto.Changeset

  schema "project_users" do
    belongs_to :project, Practicalpd.Projects.Project
    belongs_to :user, Practicalpd.Users.User

    timestamps()
  end

  def changeset(project_user, attrs) do
    project_user
    |> cast(attrs, [:project_id, :user_id])
    |> validate_required([:project_id, :user_id])
    |> unique_constraint([:project_id, :user_id])
  end
end
