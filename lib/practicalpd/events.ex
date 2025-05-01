defmodule Practicalpd.Events do
  import Ecto.Query
  alias Practicalpd.Repo
  alias Practicalpd.Events.Event

  def list_events_for_date_range(start_date, end_date) do
    Event
    |> where([e], e.date >= ^start_date and e.date <= ^end_date)
    |> preload(:project)
    |> order_by([e], asc: e.date)
    |> Repo.all()
  end
end
