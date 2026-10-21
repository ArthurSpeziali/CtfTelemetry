defmodule CtfTelemetry.Repo.Migrations.CreateDatabase do
  use Ecto.Migration

  def change do
    create table(:players) do
      add :nick, :string, null: false
      add :kills, :integer, default: 0
      add :deaths, :integer, default: 0

      timestamps()
    end

    create unique_index(:players, [:nick])
  end
end
