defmodule Sahara.Generators.Account do
  alias Sahara.Randomizers.Id

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
    # TODO: use generated ID as seed for the rest of this generator?
    %{
      id: gen_id(seed),
      name: gen_name(seed),
      type: gen_type(seed),
      subtype: gen_subtype(seed),
      currency: gen_currency(seed),
      last_four: gen_last_four(seed),
      institution: gen_institution(seed),
      enrollment_id: gen_enrollment_id(seed),
      links: gen_links("")
    }
  end

  defp gen_id(seed), do: Id.new(["acc", seed])
  defp gen_name(_seed), do: "My Checking"
  defp gen_type(_seed), do: "depository"
  defp gen_subtype(_seed), do: "checking"
  defp gen_currency(_seed), do: "USD"
  defp gen_enrollment_id(_seed), do: "enr_npg8n7kkgnu26gmimk000"
  defp gen_last_four(_seed), do: "8706"

  defp gen_institution(_seed),
    do: %{
      id: "us_bank",
      name: "US Bank"
    }

  defp gen_links(_id) do
    # TODO: pull current app base path
    %{
      balances: "https://api.teller.io/accounts/acc_npg8n7kavtkupqnj8s002/balances",
      details: "https://api.teller.io/accounts/acc_npg8n7kavtkupqnj8s002/details",
      self: "https://api.teller.io/accounts/acc_npg8n7kavtkupqnj8s002",
      transactions: "https://api.teller.io/accounts/acc_npg8n7kavtkupqnj8s002/transactions"
    }
  end
end
