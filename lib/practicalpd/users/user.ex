defmodule Practicalpd.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :name, :string
    field :email, :string
    many_to_many :projects, Practicalpd.Projects.Project, join_through: "project_users"

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email])
    |> validate_required([:name, :email])
    |> unique_constraint(:email)
  end
end
