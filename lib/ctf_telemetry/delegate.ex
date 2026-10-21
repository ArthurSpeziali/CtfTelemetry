defmodule CtfTelemetry.Delegate do
  # General Parser of one line of the chat
  @spec parser(line :: String.t()) :: no_return()
  def parser(line) when is_binary(line) do
    # Ignore '[HH:MM:SS] [Client thread/INFO]: '
    string = String.slice(line, 33..-1//1)

    # Delegate the function to the respective role
    cond do
      # Chat Role interception
      String.slice(string, 0..6//1) == "[CHAT] " ->
        # Ignore '[CHAT] ' and the final '\n'
        string = String.slice(string, 7..-2//1)
        # If all matchs, so execute the delegate function
        if string != " ", do: chat_delegate(string)

      # If no one above, just return a nil
      true ->
        nil
    end
  end

  @spec chat_delegate(string :: String.t()) :: :ok
  def chat_delegate(string) do
    # Using matching-assigning to sub-delegate each function
    case string do
      # If you kill a player... 
      <<"Você matou ", nick::binary>> ->
        # Remove the last char, in this case a '.'
        String.slice(nick, 0..-2//1)
        |> CtfTelemetry.kill()

      # If you was be killed by a player...
      <<"Você morreu para ", nick::binary>> ->
        String.slice(nick, 0..-2//1)
        |> CtfTelemetry.death()

      # If no one above, just return a :ok
      _ ->
        :ok
    end
  end
end
