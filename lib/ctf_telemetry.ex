defmodule CtfTelemetry do
  alias CtfTelemetry.Core.Players.Api
  @type status() :: %{kills: pos_integer(), deaths: pos_integer()}
  @type rank() :: [{nick :: String.t(), value :: pos_integer()}]

  # Increment +1 kill
  @spec kill(nick :: String.t()) :: :ok
  def kill(nick) when is_binary(nick) do
    case Api.get_nick(nick) do
      # If exists, update the register
      {:ok, querry} ->
        Api.update(
          nick,
          %{kills: querry.kills + 1}
        )

      # If not exists, create the register
      {:error, "not found"} ->
        Api.insert(%{nick: nick, kills: 1})
    end

    :ok
  end

  # Increment +1 death
  @spec death(nick :: String.t()) :: :ok
  def death(nick) when is_binary(nick) do
    case Api.get_nick(nick) do
      # If exists, update the register
      {:ok, querry} ->
        Api.update(
          nick,
          %{deaths: querry.deaths + 1}
        )

      # If not exists, create new register
      {:error, "not found"} ->
        Api.insert(%{nick: nick, deaths: 1})
    end

    :ok
  end

  # Get status (Kills and deaths) of a player 
  @spec get_nick(nick :: String.t()) :: status() | nil
  def get_nick(nick) when is_binary(nick) do
    case Api.get_nick(nick) do
      {:ok, querry} ->
        %{
          kills: querry.kills,
          deaths: querry.deaths
        }

      {:error, "not found"} ->
        nil
    end
  end

  # Top X kills of all players
  @spec top_kills(top :: pos_integer()) :: rank()
  def top_kills(top) when is_integer(top) do
    case Api.order(:kills, top) do
      {:ok, querry} ->
        Enum.map(querry, fn item ->
          {item.nick, item.kills}
        end)

      {:error, "not found"} ->
        nil
    end
  end

  # Top X deaths of all players
  @spec top_deaths(top :: pos_integer()) :: rank()
  def top_deaths(top) when is_integer(top) do
    case Api.order(:deaths, top) do
      {:ok, querry} ->
        Enum.map(querry, fn item ->
          {item.nick, item.deaths}
        end)

      {:error, "not found"} ->
        nil
    end
  end
end
