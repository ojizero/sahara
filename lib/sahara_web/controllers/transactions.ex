defmodule SaharaWeb.Controllers.Accounts.Transactions do
  use SaharaWeb, :controller

  alias Sahara.Generators.{Accounts, Transactions}

  def index(conn, %{"account_id" => account_id} = params) do
    count = Map.get(params, "count")
    from_id = Map.get(params, "from_id")

    cond do
      Accounts.exists?(conn.assigns.seed, account_id) ->
        json(conn, Transactions.all(conn.assigns.seed, account_id, count: count, from: from_id))

      :else ->
        :not_found
    end
  end

  def show(conn, %{"account_id" => account_id, "transaction_id" => transaction_id}) do
    case Transactions.by_id(conn.assigns.seed, account_id, transaction_id) do
      nil -> :not_found
      account -> json(conn, account)
    end
  end
end
