# CtfTelemetry

## Installation

CtfTelemetry requires **Elixir 1.18 or later** and **Erlang/OTP**. Install both, then follow the instructions for your operating system.

### macOS

The easiest option is Homebrew. If Homebrew is not installed, follow the instructions at [brew.sh](https://brew.sh/).

```sh
brew update
brew install elixir
```

Homebrew installs Erlang/OTP as a dependency when needed.

### Windows

1. Install Erlang/OTP using the official [Erlang downloads](https://www.erlang.org/downloads.html) page. Choose the Windows installer.
2. Install Elixir using the official [Elixir installation guide](https://elixir-lang.org/install.html). Choose a Windows package compatible with your installed Erlang/OTP version.
3. Open a new PowerShell window so the updated `PATH` is loaded.

Make sure the Erlang and Elixir installation directories are available in your `PATH`.

### Linux

Use your distribution's package manager if it provides Elixir 1.18 or later together with Erlang/OTP.

**Arch Linux and derivatives**

```sh
sudo pacman -S elixir
```

**Debian and Ubuntu**

```sh
sudo apt update
sudo apt install elixir
```

The versions in distribution repositories can be older than 1.18. If that happens, use a supported installation method from the official [Elixir installation guide](https://elixir-lang.org/install.html) rather than proceeding with an older version.

For other distributions, consult the official installation guide or your distribution's package documentation.

### Verify the installation

Open a terminal (or PowerShell on Windows) and run:

```sh
elixir --version
```

The output should report **Elixir 1.18 or later** and an Erlang/OTP version. If the command is not found, check that the installation directories are included in your `PATH`.

## Run the project

Clone the repository and enter its directory:

```sh
git clone https://github.com/ArthurSpeziali/CtfTelemetry.git
cd CtfTelemetry
```

Fetch the project's dependencies:

```sh
mix deps.get
```

Start the application in an interactive Elixir shell:

```sh
iex -S mix
```

## Usage

### Configure your Minecraft directory

Before starting CtfTelemetry, open `config/config.exs` and set `minecraft_path` to the directory containing your Minecraft files. The default configuration is:

```elixir
config :ctf_telemetry,
  minecraft_path: "~/.minecraft",
  buffer_time_reader: 5
```

**Keep the `~/` at the beginning of the path.** The `~` (tilde) represents your home directory. It means that the rest of the path should be resolved starting from your home folder. Do not remove it on Windows, macOS, or Linux.

Use forward slashes (`/`) in the path, including on Windows; do not use backslashes (`\`).

The default `~/.minecraft` path is commonly used by the official Minecraft launcher, TLauncher, CMclient, and other clients. If your client stores Minecraft files somewhere else, change the path to that location while preserving the `~/` prefix when the location is inside your home directory.

The `buffer_time_reader` setting controls how often the application checks the log for new messages, in seconds. Its default value is `5`, meaning it checks every five seconds.

### How data collection works

CtfTelemetry reads the Minecraft chat from:

```text
~/.minecraft/logs/latest.log
```

It looks for kill and death information in the log and records it automatically while you play. **Start CtfTelemetry after launching your Minecraft client** so it can read the log and collect information that has already been recorded as well as new events while the game is running.

The database file is named `ctftelemetry.db` and is stored in the project directory.

### Query player statistics

After starting the application with `iex -S mix`, run these commands in the IEx shell to get the kill and death counts for a specific player:

```elixir
CtfTelemetry.get_nick("NickName")
```

Example result:

```elixir
%{kills: 40, deaths: 3}
```

To display the top 10 players by kills or deaths, use:

```elixir
CtfTelemetry.top_kills(10)
CtfTelemetry.top_deaths(10)
```

These functions return a list of player names and their corresponding counts, for example:

```elixir
[{"HatCrash", 85}, ...]
```
