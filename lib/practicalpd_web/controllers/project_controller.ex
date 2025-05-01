defmodule PracticalpdWeb.ProjectController do
  use PracticalpdWeb, :controller

  alias Practicalpd.Projects
  alias Practicalpd.Projects.Project
  alias Practicalpd.Repo
  alias Practicalpd.Users

  def index(conn, _params) do
    projects = Projects.list_projects()
    render(conn, :index, projects: projects)
  end

  def new(conn, _params) do
    changeset = Projects.change_project(%Project{})
    users = Users.list_users()
    render(conn, :new, changeset: changeset, users: users)
  end

  def create(conn, %{"project" => project_params}) do
    case Projects.create_project_with_team(project_params) do
      {:ok, project} ->
        conn
        |> put_flash(:info, "Project created successfully.")
        |> redirect(to: ~p"/projects/#{project}")

      {:error, %Ecto.Changeset{} = changeset} ->
        users = Users.list_users()
        render(conn, :new, changeset: changeset, users: users)
    end
  end

  def show(conn, %{"id" => id}) do
    project = Projects.get_project!(id)
    |> Repo.preload(:team_members)
    render(conn, :show, project: project)
  end

  def edit(conn, %{"id" => id}) do
    project = Projects.get_project!(id)
    |> Repo.preload(:team_members)
    changeset = Projects.change_project(project)
    users = Users.list_users()
    render(conn, :edit, project: project, changeset: changeset, users: users)
  end

  def update(conn, %{"id" => id, "project" => project_params}) do
    project = Projects.get_project!(id)

    case Projects.update_project_with_team(project, project_params) do
      {:ok, project} ->
        conn
        |> put_flash(:info, "Project updated successfully.")
        |> redirect(to: ~p"/projects/#{project}")

      {:error, %Ecto.Changeset{} = changeset} ->
        users = Users.list_users()
        render(conn, :edit, project: project, changeset: changeset, users: users)
    end
  end

  def delete(conn, %{"id" => id}) do
    project = Projects.get_project!(id)
    {:ok, _project} = Projects.delete_project(project)

    conn
    |> put_flash(:info, "Project deleted successfully.")
    |> redirect(to: ~p"/projects")
  end
end
