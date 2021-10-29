defmodule SaharaWeb.Controllers.Accounts do
  use SaharaWeb, :controller

  alias Sahara.Generators

  def index(conn, _params) do
    # 1. seed from auth
    # 2. pass seed to accounts generator

    json(conn, Generators.Accounts.all(""))
  end

  def show(conn, _params) do
    # 1. seed from auth
    # 2. pass seed to accounts generator
    # 3. use given id to get a generated account

    json(conn, Generators.Account.new(""))
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
