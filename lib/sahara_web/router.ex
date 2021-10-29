defmodule SaharaWeb.Router do
  use SaharaWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug SaharaWeb.Plugs.Auth
  end

  scope "/accounts", SaharaWeb.Controllers do
    pipe_through :api

    get "/", Accounts, :index
    get "/:account_id", Accounts, :show
    get "/:account_id/details", Accounts, :details
    get "/:account_id/balances", Accounts, :balances

    get "/:account_id/transactions", Accounts.Transactions, :index
    get "/:account_id/transactions/:transaction_id", Accounts.Transactions, :show
  end

  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: SaharaWeb.Telemetry
    end
  end
end
