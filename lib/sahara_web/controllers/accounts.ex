defmodule SaharaWeb.Controllers.Accounts do
  use SaharaWeb, :controller

  alias Sahara.Generators.Accounts

  def index(conn, _params) do
    json(conn, Accounts.all(conn.assigns.seed))
  end

  def show(conn, %{"account_id" => account_id}) do
    case Accounts.by_id(conn.assigns.seed, account_id) do
      nil -> :not_found
      account -> json(conn, account)
    end
  end

  def details(conn, _params) do
    json(
      conn,
      %{
        account_id: "acc_npg8n7kavtkupqnj8s002",
        account_number: "797677018706",
        links: %{
          account: "https://api.teller.io/accounts/acc_npg8n7kavtkupqnj8s002",
          self: "https://api.teller.io/accounts/acc_npg8n7kavtkupqnj8s002/details"
        },
        routing_numbers: %{
          ach: "799553321"
        }
      }
    )
  end

  def balances(conn, _params) do
    json(
      conn,
      %{
        account_id: "acc_npg8n7kavtkupqnj8s002",
        available: "36986.44",
        ledger: "37110.46",
        links: %{
          account: "https://api.teller.io/accounts/acc_npg8n7kavtkupqnj8s002",
          self: "https://api.teller.io/accounts/acc_npg8n7kavtkupqnj8s002/balances"
        }
      }
    )
  end
end
