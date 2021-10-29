defmodule SaharaWeb.Controllers.Accounts.Transactions do
  use SaharaWeb, :controller

  alias Sahara.Generators.Transactions

  def index(conn, %{"account_id" => account_id} = params) do
    # TODO: for pagination
    _count = Map.get(params, "count", nil)
    _from_id = Map.get(params, "from_id", nil)

    json(conn, Transactions.all(conn.assigns.seed, account_id))
  end

  def show(conn, %{"account_id" => account_id, "transaction_id" => transaction_id}) do
    case Transactions.by_id(conn.assigns.seed, account_id, transaction_id) do
      nil -> :not_found
      account -> json(conn, account)
    end
  end
end
