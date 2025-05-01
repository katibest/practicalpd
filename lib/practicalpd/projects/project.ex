defmodule Practicalpd.Projects.Project do
  use Ecto.Schema
  import Ecto.Changeset

  schema "projects" do
    field :title, :string
    field :status, :string
    field :client_name, :string
    field :due_date, :date
    field :description, :string
    many_to_many :team_members, Practicalpd.Users.User, join_through: "project_users"

    timestamps()
  end

  @doc false
  def changeset(project, attrs) do
    project
    |> cast(attrs, [:title, :status, :client_name, :due_date, :description])
    |> validate_required([:title, :status, :client_name, :due_date, :description])
    |> validate_inclusion(:status, ["planning", "in_progress", "completed"])
  end
end
