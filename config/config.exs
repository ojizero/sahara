use Mix.Config

host = System.get_env("HOST", "localhost")
port = System.get_env("PORT", "4000")
scheme = System.get_env("SCHEME", "http")

config :sahara, SaharaWeb.Endpoint,
  url: [host: host],
  secret_key_base: "TvYXhUFTZG4a1tHJ5tQtqK6dabPh8CmBIS15BaSDGSYhKDkN3vhsj430Rl99DUl+",
  render_errors: [view: SaharaWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Sahara.PubSub,
  live_view: [signing_salt: "ya53mLMM"]

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :json_library, Jason

config :faker, :random_module, Sahara.Randomizers.Faker

config :sahara, :base_endpoint, "#{scheme}://#{host}:#{port}"

import_config "#{Mix.env()}.exs"
