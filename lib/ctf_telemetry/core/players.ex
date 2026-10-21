defmodule CtfTelemetry.Core.Players do
  use Ecto.Schema

  schema "players" do
    field(:nick, :string)
    field(:kills, :integer, default: 0)
    field(:deaths, :integer, default: 0)

    timestamps()
  end

  def changeset(model, params) do
    Ecto.Changeset.cast(model, params, [:nick, :kills, :deaths])
    |> Ecto.Changeset.unique_constraint(:nick)
  end
end
