defmodule CtfTelemetry.Server.ReaderServer do
  use GenServer
  @mod __MODULE__
  # The LOG file of Minecraft Client
  @log (Application.compile_env(:ctf_telemetry, :minecraft_path) <> "/logs/latest.log")
       |> Path.expand()

  def start_link(opts \\ nil) do
    GenServer.start_link(@mod, opts, name: @mod)
  end

  @impl true
  def init(_state) do
    # Create or load the JSON Statistics Configuration
    statistics = load_json()

    # Compare the last inode saved with the new
    inode = File.stat!(@log).inode

    if statistics["last_inode"] == inode do
      # If the file already read before, truncates it now
      File.write!(@log, "", [:write])
    else
      # If not, add in JSON Statistics Configuration 
      dump_json(%{inode: inode})
    end

    # Streams the file. Just pick what you need (Lazying)
    stream = File.stream!(@log)

    # Link the new spawning function to the GenServer (If one dies, the server die)
    spawn_link(
      @mod,
      :reader,
      [stream, 0, Enum.count(stream)]
    )

    {:ok, stream}
  end

  @spec reader(stream :: File.Stream.t(), next :: non_neg_integer(), len :: pos_integer()) ::
          no_return()
  def reader(stream, next, len) when next < len do
    # If there's more lines in the Stream,
    # Pick the next line avaliable
    line = Enum.at(stream, next)

    # Calls the general parser
    CtfTelemetry.Delegate.parser(line)
    # Recursive function
    reader(stream, next + 1, len)
  end

  def reader(stream, next, _len) do
    # If there's no more lines in the file, 
    # Sleep some seconds (Default is 5 seconds)
    Process.sleep(
      # Get's the value in config.exs
      Application.get_env(
        :ctf_telemetry,
        :buffer_time_reader
      ) * 1000
    )

    # So, recursive the function with same inputs
    reader(
      stream,
      next,
      Enum.count(stream)
    )
  end

  # Private funtions 
  defp load_json() do
    if File.exists?("statistics.json") do
      File.read!("statistics.json")
      |> JSON.decode!()
    else
      content =
        Application.get_env(:ctf_telemetry, :statistics_config)
        |> JSON.encode!()

      File.write!("statistics.json", content)
      JSON.encode!(content)
    end
  end

  defp dump_json(update_map) do
    if File.exists?("statistics.json") do
      old_config =
        File.read!("statistics.json")
        |> JSON.decode!()

      new_config =
        Map.merge(old_config, update_map)
        |> JSON.encode!()

      File.write!("statistics.json", new_config)
    else
      content =
        Application.get_env(:ctf_telemetry, :statistics_config)
        |> JSON.encode!()

      File.write!("statistics.json", content)
      content
    end
  end
end
