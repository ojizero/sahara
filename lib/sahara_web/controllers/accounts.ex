defmodule SaharaWeb.Controllers.Accounts do
  use SaharaWeb, :controller

  alias Sahara.Generators.{
    Accounts,
    AccountDetails,
    AccountBalances
  }

  def index(conn, _params) do
    json(conn, Accounts.all(conn.assigns.seed))
  end

  def show(conn, %{"account_id" => account_id}) do
    case Accounts.by_id(conn.assigns.seed, account_id) do
      nil -> :not_found
      account -> json(conn, account)
    end
  end

  def details(conn, %{"account_id" => account_id}) do
    case AccountDetails.for_account(conn.assigns.seed, account_id) do
      nil -> :not_found
      account_details -> json(conn, account_details)
    end
  end

  def balances(conn, %{"account_id" => account_id}) do
    case AccountBalances.for_account(conn.assigns.seed, account_id) do
      nil -> :not_found
      account_balances -> json(conn, account_balances)
    end
  end
end
