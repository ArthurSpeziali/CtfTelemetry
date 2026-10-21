defmodule CtfTelemetry.Repo do
  use Ecto.Repo,
    otp_app: :ctf_telemetry,
    adapter: Ecto.Adapters.SQLite3
end
