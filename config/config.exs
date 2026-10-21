import Config

config :ctf_telemetry,
  ecto_repos: [CtfTelemetry.Repo]

config :ctf_telemetry,
  minecraft_path: "~/.minecraft",
  buffer_time_reader: 5

config :ctf_telemetry, CtfTelemetry.Repo, database: "ctftelemetry.db"
