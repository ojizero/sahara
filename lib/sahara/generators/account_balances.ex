defmodule Sahara.Generators.AccountBalances do
  alias Sahara.Helpers.BasePath
  alias Sahara.Randomizers.Number
  alias Sahara.Generators.Accounts

  def for(seed, account_id) do
    if Accounts.exists?(seed, account_id),
      do: gen_balances(seed, account_id),
      else: nil
  end

  defp gen_balances(seed, account_id) do
    ledger_amount = Number.ledger_amount([seed, account_id])

    %{
      account_id: account_id,
      # TODO: randomize those (make randomized outstanding/pending transactions and subtract them from ledger)
      available: "36986.44",
      # TODO: randomize those
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
