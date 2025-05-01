defmodule Practicalpd.Repo.Migrations.CreateEvents do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :title, :string
      add :description, :text
      add :date, :date
      add :project_id, references(:projects, on_delete: :delete_all)

      timestamps()
    end

    create index(:events, [:project_id])
    create index(:events, [:date])
  end
end
