defmodule SaharaWeb.Controllers.Fallback do
  use SaharaWeb, :controller

  def call(conn, :not_found) do
    conn
    |> put_status(:not_found)
    |> json(%{
      error: %{
        message: "The requested resource does not exist",
        code: "not_found"
      }
    })
    |> halt()
  end
end
