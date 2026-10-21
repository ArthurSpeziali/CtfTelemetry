defmodule CtfTelemetry.Core.Players.Api do
  import Ecto.Query, except: [update: 2]
  alias CtfTelemetry.Core.Players
  alias CtfTelemetry.Repo

  def all() do
    Repo.all(Players)
    |> case do
      querry -> {:ok, querry}
    end
  end

  def insert(params) do
    struct(%Players{}, params)
    |> Repo.insert()
  end

  def get_nick(nick) do
    from(Players)
    |> where(nick: ^nick)
    |> Repo.one()
    |> case do
      nil -> {:error, "not found"}
      querry -> {:ok, querry}
    end
  end

  def get(player) do
    Repo.get(Players, player)
    |> case do
      nil -> {:error, "not found"}
      querry -> {:ok, querry}
    end
  end

  def delete(player) do
    case get(player) do
      {:ok, querry} -> Repo.delete(querry)
      error -> error
    end
  end

  def update(player, params) do
    with {:ok, querry} <- get(player),
         changeset <- Players.changeset(querry, params),
         {:ok, new_querry} <- Repo.update(changeset) do
      {:ok, new_querry}
    else
      error -> error
    end
  end

  def order(field, limit) do
    from(Players)
    |> order_by(desc: ^field)
    |> limit(^limit)
    |> Repo.all()
    |> case do
      nil -> {:error, "not found"}
      querry -> {:ok, querry}
    end
  end
end
