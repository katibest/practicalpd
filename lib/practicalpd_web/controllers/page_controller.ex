defmodule PracticalpdWeb.PageController do
  use PracticalpdWeb, :controller

  alias Practicalpd.{Projects, Users}

  def home(conn, _params) do
    # Get the first project and all users
    project = Projects.get_first_project()
    users = Users.list_users()
    render(conn, :home, project: project, users: users)
  end
end
