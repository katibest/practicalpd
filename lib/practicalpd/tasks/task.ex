defmodule Practicalpd.Tasks.Task do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tasks" do
    field :title, :string
    field :description, :string
    field :status, :string
    belongs_to :project, Practicalpd.Projects.Project
    belongs_to :user, Practicalpd.Users.User

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:title, :description, :status, :project_id, :user_id])
    |> validate_required([:title, :description, :status, :project_id, :user_id])
    |> validate_inclusion(:status, ["todo", "in_progress", "completed"])
  end
end
