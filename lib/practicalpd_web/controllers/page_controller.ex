defmodule PracticalpdWeb.PageController do
  use PracticalpdWeb, :controller

  alias Practicalpd.Projects
  alias Practicalpd.Events

  def home(conn, _params) do
    projects = Projects.list_projects()
    today = Date.utc_today()
    end_date = Date.add(today, 3)
    date_range = Date.range(today, end_date)
    events = Events.list_events_for_date_range(today, end_date)

    events_by_date = Enum.group_by(events, & &1.date)

    render(conn, :home,
      projects: projects,
      date_range: date_range,
      events_by_date: events_by_date
    )
  end
end
