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

alias Practicalpd.{Repo, Users.User, Projects.Project, Tasks.Task, Events.Event}

# Create users
users = [
  %{
    name: "John Smith",
    email: "john@example.com"
  },
  %{
    name: "Jane Doe",
    email: "jane@example.com"
  },
  %{
    name: "Bob Wilson",
    email: "bob@example.com"
  }
]

created_users = Enum.map(users, fn user_data ->
  Repo.insert!(%User{
    name: user_data.name,
    email: user_data.email
  })
end)

# Create projects with all required fields
projects_data = [
  %{
    title: "Website Redesign",
    description: "Complete redesign of the company website with modern UI/UX",
    status: "in_progress",
    client_name: "Acme Corporation",
    due_date: ~D[2024-12-31]
  },
  %{
    title: "Mobile App Development",
    description: "Development of a new mobile application for iOS and Android",
    status: "planning",
    client_name: "TechStart Inc",
    due_date: ~D[2024-10-15]
  },
  %{
    title: "Marketing Campaign",
    description: "Q3 marketing campaign planning and execution",
    status: "completed",
    client_name: "Global Marketing Co",
    due_date: ~D[2024-09-30]
  }
]

# Insert projects and create associations with users
created_projects = Enum.map(projects_data, fn project_data ->
  project = Repo.insert!(%Project{
    title: project_data.title,
    description: project_data.description,
    status: project_data.status,
    client_name: project_data.client_name,
    due_date: project_data.due_date
  })

  # Assign random team members to each project (2-3 members per project)
  team_size = Enum.random(2..3)
  project_users = Enum.take_random(created_users, team_size)

  Enum.each(project_users, fn user ->
    Repo.insert!(%Practicalpd.ProjectUser{
      project_id: project.id,
      user_id: user.id
    })
  end)

  project
end)

# Create tasks for each project
tasks_data = [
  %{
    title: "Design Homepage",
    description: "Create new homepage design with modern layout",
    status: "in_progress"
  },
  %{
    title: "Implement User Authentication",
    description: "Set up user authentication system",
    status: "todo"
  },
  %{
    title: "Create Social Media Content",
    description: "Develop content for social media platforms",
    status: "completed"
  },
  %{
    title: "Optimize Database Queries",
    description: "Review and optimize database queries for better performance",
    status: "in_progress"
  }
]

# Distribute tasks across projects and users
Enum.each(tasks_data, fn task_data ->
  project = Enum.random(created_projects)
  user = Enum.random(created_users)

  %Task{}
  |> Task.changeset(Map.merge(task_data, %{
    project_id: project.id,
    user_id: user.id
  }))
  |> Repo.insert!()
end)

# Create sample events
today = Date.utc_today()

events = [
  %{
    title: "Project Kickoff Meeting",
    description: "Initial meeting with the client to discuss project requirements",
    date: today,
    project_id: Enum.at(created_projects, 0).id
  },
  %{
    title: "Design Review",
    description: "Review the initial design mockups with the team",
    date: Date.add(today, 1),
    project_id: Enum.at(created_projects, 1).id
  },
  %{
    title: "Client Presentation",
    description: "Present the first prototype to the client",
    date: Date.add(today, 2),
    project_id: Enum.at(created_projects, 2).id
  },
  %{
    title: "Team Standup",
    description: "Daily team sync meeting",
    date: Date.add(today, 3),
    project_id: Enum.at(created_projects, 0).id
  }
]

for event_attrs <- events do
  %Event{}
  |> Event.changeset(event_attrs)
  |> Repo.insert!()
end
