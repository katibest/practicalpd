defmodule Practicalpd.Projects do
  import Ecto.Query, warn: false
  alias Practicalpd.Repo
  alias Practicalpd.Projects.Project

  def get_first_project do
    Project
    |> first()
    |> preload(:team_members)
    |> Repo.one()
  end

  def list_projects do
    Project
    |> preload(:team_members)
    |> Repo.all()
  end

  def get_project!(id), do: Repo.get!(Project, id)

  def create_project(attrs \\ %{}) do
    %Project{}
    |> Project.changeset(attrs)
    |> Repo.insert()
  end

  def update_project(%Project{} = project, attrs) do
    project
    |> Project.changeset(attrs)
    |> Repo.update()
  end

  def update_project_with_team(%Project{} = project, attrs) do
    team_member_ids = Map.get(attrs, "team_member_ids", [])
    attrs = Map.drop(attrs, ["team_member_ids"])

    Repo.transaction(fn ->
      case update_project(project, attrs) do
        {:ok, project} ->
          # Delete existing team members
          Repo.delete_all(from(pu in "project_users", where: pu.project_id == ^project.id))

          # Add new team members
          now = NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second)
          team_member_records = Enum.map(team_member_ids, fn user_id ->
            %{
              project_id: project.id,
              user_id: String.to_integer(user_id),
              inserted_at: now,
              updated_at: now
            }
          end)

          {_count, _} = Repo.insert_all("project_users", team_member_records)
          project = Repo.preload(project, :team_members)
          project
        {:error, changeset} ->
          Repo.rollback(changeset)
      end
    end)
  end

  def delete_project(%Project{} = project) do
    Repo.delete(project)
  end

  def change_project(%Project{} = project, attrs \\ %{}) do
    Project.changeset(project, attrs)
  end

  def create_project_with_team(attrs \\ %{}) do
    team_member_ids = Map.get(attrs, "team_member_ids", [])
    attrs = Map.drop(attrs, ["team_member_ids"])

    Repo.transaction(fn ->
      case create_project(attrs) do
        {:ok, project} ->
          # Associate team members using insert_all
          now = NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second)
          team_member_records = Enum.map(team_member_ids, fn user_id ->
            %{
              project_id: project.id,
              user_id: String.to_integer(user_id),
              inserted_at: now,
              updated_at: now
            }
          end)

          {_count, _} = Repo.insert_all("project_users", team_member_records)
          project = Repo.preload(project, :team_members)
          project
        {:error, changeset} ->
          Repo.rollback(changeset)
      end
    end)
  end
end
