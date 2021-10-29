defmodule SaharaWeb.Router do
  use SaharaWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    # authn
  end

  scope "/", SaharaWeb do
    pipe_through :api
  end

  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: SaharaWeb.Telemetry
    end
  end
end
