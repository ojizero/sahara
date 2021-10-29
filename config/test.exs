use Mix.Config

config :sahara, SaharaWeb.Endpoint,
  http: [port: 4002],
  server: false

config :logger, level: :warn
