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
    stream = File.stream!(@log)

    # Link the new spawning function to the GenServer (If one dies, the server die)
    spawn_link(
      @mod,
      :reader,
      [stream, 1, Enum.count(stream)]
    )

    {:ok, stream}
  end

  @spec reader(stream :: File.Stream.t(), next :: pos_integer(), len :: pos_integer()) ::
          no_return()
  def reader(stream, next, len) when next <= len do
    # If there's more lines in the Stream,
    # Pick the next line avaliable
    line = Enum.at(stream, next)

    # Calls the general parser 
    CtfTelemetry.parser(line)
    IO.gets("Enter: ")
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
end
