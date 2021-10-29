defmodule Sahara.Generators.Accounts do
  alias Sahara.Helpers.BasePath
  alias Sahara.Randomizers.Id
  alias Sahara.Randomizers.Name
  alias Sahara.Randomizers.Number
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

  @spec all(iodata) :: [t]
  def all(seed) do
    seed
    |> ids()
    |> Enum.map(&gen_account/1)
  end

  @spec by_id(iodata, String.t()) :: t | nil
  def by_id(seed, id) do
    if exists?(seed, id),
      do: gen_account(id),
      else: nil
  end

  @spec exists?(iodata, String.t()) :: boolean
  def exists?(seed, id), do: id in ids(seed)

  defp ids(seed) do
    accounts_count = Sahara.Randomizer.bounded_number(seed, 5)

    Enum.map(1..accounts_count, fn i -> gen_id([seed, i]) end)
  end

  defp gen_account(id) do
    %{
      id: id,
      name: gen_name(id),
      type: gen_type(id),
      subtype: gen_subtype(id),
      currency: gen_currency(id),
      last_four: gen_last_four(id),
      institution: gen_institution(id),
      enrollment_id: gen_enrollment_id(id),
      links: gen_links(id)
    }
  end

  defp gen_id(seed), do: Id.new(["acc", seed])
  defp gen_name(seed), do: Name.account(seed)
  defp gen_type(_seed), do: "depository"
  defp gen_subtype(_seed), do: "checking"
  defp gen_currency(_seed), do: "USD"
  defp gen_enrollment_id(seed), do: Id.new(["enr", seed])
  defp gen_last_four(seed), do: Number.new(seed, 4)

  defp gen_institution(seed), do: Institutions.random(seed)

  defp gen_links(id) do
    %{
      self: "#{BasePath.base_endpoint()}/accounts/#{id}",
      details: "#{BasePath.base_endpoint()}/accounts/#{id}/details",
      balances: "#{BasePath.base_endpoint()}/accounts/#{id}/balances",
      transactions: "#{BasePath.base_endpoint()}/accounts/#{id}/transactions"
    }
  end
end
