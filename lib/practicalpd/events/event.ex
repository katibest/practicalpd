defmodule Practicalpd.Events.Event do
  use Ecto.Schema
  import Ecto.Changeset

  schema "events" do
    field :title, :string
    field :description, :string
    field :date, :date
    belongs_to :project, Practicalpd.Projects.Project

    timestamps()
  end

  @doc false
  def changeset(event, attrs) do
    event
    |> cast(attrs, [:title, :description, :date, :project_id])
    |> validate_required([:title, :description, :date, :project_id])
  end
end
