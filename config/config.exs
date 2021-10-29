# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :sahara, SaharaWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "TvYXhUFTZG4a1tHJ5tQtqK6dabPh8CmBIS15BaSDGSYhKDkN3vhsj430Rl99DUl+",
  render_errors: [view: SaharaWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Sahara.PubSub,
  live_view: [signing_salt: "ya53mLMM"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
