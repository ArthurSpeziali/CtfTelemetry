defmodule CtfTelemetry.Context do
  alias CtfTelemetry.Core.Players.Api

  @spec kill(nick :: String.t()) :: :ok
  def kill(nick) when is_binary(nick) do
    case Api.get_nick(nick) do
      {:ok, querry} ->
        Api.update(
          nick,
          %{kills: querry.kills + 1}
        )

      {:error, "not found"} ->
        Api.insert(%{nick: nick, kills: 1})
    end

    :ok
  end

  @spec death(nick :: String.t()) :: :ok
  def death(nick) when is_binary(nick) do
    case Api.get_nick(nick) do
      {:ok, querry} ->
        Api.update(
          nick,
          %{deaths: querry.deaths + 1}
        )

      {:error, "not found"} ->
        Api.insert(%{nick: nick, deaths: 1})
    end

    :ok
  end

  @spec get_status(nick :: String.t()) :: %{kills: pos_integer(), deaths: pos_integer()} | nil
  def get_status(nick) when is_binary(nick) do
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
end
