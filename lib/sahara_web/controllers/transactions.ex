defmodule SaharaWeb.Controllers.Accounts.Transactions do
  use SaharaWeb, :controller

  def index(conn, params) do
    # TODO: for pagination
    _count = Map.get(params, "count", nil)
    _from_id = Map.get(params, "from_id", nil)

    json(
      conn,
      [
        %{
          account_id: "acc_npg8n7kavtkupqnj8s002",
          amount: "-124.02",
          date: "2021-10-27",
          description: "Starbucks",
          details: %{
            category: "dining",
            counterparty: %{
              name: "STARBUCKS",
              type: "organization"
            },
            processing_status: "complete"
          },
          id: "txn_npg8n7u3vtkupqnj8s002",
          links: %{
            account: "https://api.teller.io/accounts/acc_npg8n7kavtkupqnj8s002",
            self:
              "https://api.teller.io/accounts/acc_npg8n7kavtkupqnj8s002/transactions/txn_npg8n7u3vtkupqnj8s002"
          },
          running_balance: nil,
          status: "pending",
          type: "card_payment"
        }
      ]
    )
  end

  def show(conn, _params) do
    json(
      conn,
      %{
        account_id: "acc_npg8n7kavtkupqnj8s002",
        amount: "-124.02",
        date: "2021-10-27",
        description: "Starbucks",
        details: %{
          category: "dining",
          counterparty: %{
            name: "STARBUCKS",
            type: "organization"
          },
          processing_status: "complete"
        },
        id: "txn_npg8n7u3vtkupqnj8s002",
        links: %{
          account: "https://api.teller.io/accounts/acc_npg8n7kavtkupqnj8s002",
          self:
            "https://api.teller.io/accounts/acc_npg8n7kavtkupqnj8s002/transactions/txn_npg8n7u3vtkupqnj8s002"
        },
        running_balance: nil,
        status: "pending",
        type: "card_payment"
      }
    )
  end
end
