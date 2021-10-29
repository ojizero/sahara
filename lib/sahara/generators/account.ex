defmodule Sahara.Generators.Account do
  alias Sahara.Randomizers.Id
  alias Sahara.Seeds.Institutions

  @type t :: %{
          id: String.t(),
          name: String.t(),
          type: String.t(),
          subtype: String.t(),
          currency: String.t(),
          last_four: String.t(),
          institution: %{
            id: String.t(),
            name: String.t()
          },
          enrollment_id: String.t(),
          links: %{
            self: String.t(),
            details: String.t(),
            balances: String.t(),
            transactions: String.t()
          }
        }

  @spec new(iodata) :: t
  def new(seed) do
    account_id = gen_id(seed)

    %{
      id: account_id,
      name: gen_name(account_id),
      type: gen_type(account_id),
      subtype: gen_subtype(account_id),
      currency: gen_currency(account_id),
      last_four: gen_last_four(account_id),
      institution: gen_institution(account_id),
      enrollment_id: gen_enrollment_id(account_id),
      links: gen_links(account_id)
    }
  end

  defp gen_id(seed), do: Id.new(["acc", seed])
  defp gen_name(_seed), do: "My Checking"
  defp gen_type(_seed), do: "depository"
  defp gen_subtype(_seed), do: "checking"
  defp gen_currency(_seed), do: "USD"
  defp gen_enrollment_id(seed), do: Id.new(["enr", seed])
  defp gen_last_four(_seed), do: "8706"

  defp gen_institution(seed), do: Institutions.random(seed)

  defp gen_links(id) do
    %{
      self: "https://api.teller.io/accounts/#{id}",
      details: "https://api.teller.io/accounts/#{id}/details",
      balances: "https://api.teller.io/accounts/#{id}/balances",
      transactions: "https://api.teller.io/accounts/#{id}/transactions"
    }
  end
end
