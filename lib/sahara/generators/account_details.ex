defmodule Sahara.Generators.AccountDetails do
  alias Sahara.Helpers.BasePath
  alias Sahara.Randomizers.Number
  alias Sahara.Generators.Accounts

  def for(seed, account_id) do
    if Accounts.exists?(seed, account_id),
      do: gen_details(seed, account_id),
      else: nil
  end

  defp gen_details(_seed, account_id) do
    %{
      account_id: account_id,
      links: gen_links(account_id),
      account_number: gen_account_number(account_id),
      routing_numbers: gen_routing_numbers(account_id)
    }
  end

  defp gen_account_number(seed), do: Number.new(seed, 12)

  defp gen_routing_numbers(seed),
    do: %{
      ach: Number.new(seed, 9)
    }

  defp gen_links(id) do
    %{
      account: "#{BasePath.base_endpoint()}/accounts/#{id}",
      self: "#{BasePath.base_endpoint()}/accounts/#{id}/details"
    }
  end
end
