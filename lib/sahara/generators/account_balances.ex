defmodule Sahara.Generators.AccountBalances do
  alias Sahara.Generators.Accounts

  def for(seed, account_id) do
    if Accounts.exists?(seed, account_id),
      do: gen_balances(seed, account_id),
      else: nil
  end

  defp gen_balances(_seed, account_id) do
    %{
      account_id: account_id,
      # TODO: randomize those
      available: "36986.44",
      # TODO: randomize those
      ledger: "37110.46",
      links: gen_links(account_id)
    }
  end

  defp gen_links(id) do
    %{
      account: "https://api.teller.io/accounts/#{id}",
      self: "https://api.teller.io/accounts/#{id}/balances"
    }
  end
end
