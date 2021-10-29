defmodule Sahara.Generators.AccountBalances do
  alias Sahara.Helpers.BasePath
  alias Sahara.Randomizers.Number
  alias Sahara.Generators.Accounts

  @type t :: %{
          account_id: String.t(),
          available: String.t(),
          ledger: String.t(),
          links: %{account: String.t(), self: String.t()}
        }

  @spec for_account(iodata, String.t()) :: t | nil
  def for_account(seed, account_id) do
    if Accounts.exists?(seed, account_id),
      do: gen_balances(seed, account_id),
      else: nil
  end

  defp gen_balances(seed, account_id) do
    ledger_amount = Number.ledger_amount([seed, account_id])

    %{
      account_id: account_id,
      # This should be the amount of ledger minus any pending transactions
      # from the what I can tell in the actual sandbox API they numbers
      # don't add up so I'll leave it like this for now.
      available: ledger_amount,
      ledger: ledger_amount,
      links: gen_links(account_id)
    }
  end

  defp gen_links(id) do
    %{
      account: "#{BasePath.base_endpoint()}/accounts/#{id}",
      self: "#{BasePath.base_endpoint()}/accounts/#{id}/balances"
    }
  end
end
