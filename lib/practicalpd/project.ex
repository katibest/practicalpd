defmodule Practicalpd.Project do
  use Ecto.Schema
  import Ecto.Changeset

  schema "projects" do
    field :status, :string
    field :description, :string
    field :title, :string
    field :user_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(project, attrs) do
    project
    |> cast(attrs, [:title, :description, :status])
    |> validate_required([:title, :description, :status])
  end
end
