defmodule Practicalpd.Repo.Migrations.AddFieldsToProjects do
  use Ecto.Migration

  def change do
    alter table(:projects) do
      add :client_name, :string
      add :due_date, :date
    end

    create table(:project_users) do
      add :project_id, references(:projects, on_delete: :delete_all)
      add :user_id, references(:users, on_delete: :delete_all)
      timestamps()
    end

    create index(:project_users, [:project_id])
    create index(:project_users, [:user_id])
    create unique_index(:project_users, [:project_id, :user_id])
  end
end
