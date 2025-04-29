# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Practicalpd.Repo.insert!(%Practicalpd.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Practicalpd.{Repo, User, Project, Task}

# Create users
users = [
  %{
    email: "alice@example.com",
    name: "Alice Johnson",
    password_hash: "password123"
  },
  %{
    email: "bob@example.com",
    name: "Bob Smith",
    password_hash: "password123"
  },
  %{
    email: "charlie@example.com",
    name: "Charlie Brown",
    password_hash: "password123"
  }
]

Enum.each(users, fn user_data ->
  %User{}
  |> User.changeset(user_data)
  |> Repo.insert!()
end)

# Get all users
users = Repo.all(User)

# Create projects
projects = [
  %{
    title: "Website Redesign",
    description: "Complete redesign of the company website with modern UI/UX",
    status: "in_progress",
    user_id: Enum.at(users, 0).id
  },
  %{
    title: "Mobile App Development",
    description: "Development of a new mobile application for iOS and Android",
    status: "planning",
    user_id: Enum.at(users, 1).id
  },
  %{
    title: "Marketing Campaign",
    description: "Q3 marketing campaign planning and execution",
    status: "completed",
    user_id: Enum.at(users, 2).id
  }
]

Enum.each(projects, fn project_data ->
  %Project{}
  |> Project.changeset(project_data)
  |> Repo.insert!()
end)

# Get all projects
projects = Repo.all(Project)

# Create tasks
tasks = [
  %{
    title: "Design Homepage",
    description: "Create new homepage design with modern layout",
    status: "in_progress",
    project_id: Enum.at(projects, 0).id,
    user_id: Enum.at(users, 0).id
  },
  %{
    title: "Implement User Authentication",
    description: "Set up user authentication system for the mobile app",
    status: "todo",
    project_id: Enum.at(projects, 1).id,
    user_id: Enum.at(users, 1).id
  },
  %{
    title: "Create Social Media Content",
    description: "Develop content for social media platforms",
    status: "completed",
    project_id: Enum.at(projects, 2).id,
    user_id: Enum.at(users, 2).id
  },
  %{
    title: "Optimize Database Queries",
    description: "Review and optimize database queries for better performance",
    status: "in_progress",
    project_id: Enum.at(projects, 0).id,
    user_id: Enum.at(users, 1).id
  }
]

Enum.each(tasks, fn task_data ->
  %Task{}
  |> Task.changeset(task_data)
  |> Repo.insert!()
end)
