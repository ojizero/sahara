defmodule Sahara.Generators.Transactions do
  alias Sahara.Helpers.BasePath
  alias Sahara.Randomizer
  alias Sahara.Randomizers.Id
  alias Sahara.Randomizers.Name
  alias Sahara.Randomizers.Number

  alias Sahara.Seeds.Categories

  @type t :: %{
          account_id: String.t(),
          amount: String.t(),
          date: String.t(),
          description: String.t(),
          details: %{
            category: String.t(),
            counterparty: %{name: String.t(), type: String.t()},
            processing_status: String.t()
          },
          id: String.t(),
          links: %{account: String.t(), self: String.t()},
          running_balance: nil,
          status: String.t(),
          type: String.t()
        }

  @type pagination ::
          []
          | [count: String.t()]
          | [count: String.t(), from: String.t()]

  @spec all(iodata, String.t()) :: [t]
  @spec all(iodata, String.t(), pagination) :: [t]
  def all(seed, account_id, opts \\ [])

  def all(seed, account_id, count: count, from: from) when not is_nil(count) and count != "" do
    all = all(seed, account_id)

    case Integer.parse(count) do
      {count, ""} ->
        if is_nil(from) or from == "",
          do: Enum.take(all, count),
          else: all |> Enum.drop_while(fn txn -> txn.id == from end) |> tl() |> Enum.take(count)

      _else ->
        all
    end
  end

  def all(seed, account_id, count: count) when not is_nil(count) and count != "" do
    all(seed, account_id, count: count, from: nil)
  end

  def all(seed, account_id, _opts) do
    seed
    |> ids(account_id)
    |> Enum.map(&gen_transaction(account_id, &1))
  end

  @spec by_id(any, any, any) :: t | nil
  def by_id(seed, account_id, transaction_id) do
    seed
    |> ids(account_id)
    |> Enum.find(fn {id, _days_ago} -> id == transaction_id end)
    |> case do
      nil -> nil
      id_and_days_ago -> gen_transaction(account_id, id_and_days_ago)
    end
  end

  defp ids(seed, account_id) do
    Enum.flat_map(
      0..90,
      fn days_ago ->
        count = Randomizer.bounded_number([seed, account_id, days_ago], 5)

        if count == 0,
          do: [],
          else:
            Enum.map(1..count, fn i -> {gen_id([seed, account_id, days_ago, i]), days_ago} end)
      end
    )
  end

  defp gen_transaction(account_id, {transaction_id, days_ago}) do
    counter_party = gen_counterparty(transaction_id)

    %{
      id: transaction_id,
      account_id: account_id,
      amount: gen_amount(transaction_id),
      date: now_minus_days(days_ago),
      description: counter_party.name,
      details: %{
        # Unsure if to use the example merchants given,
        # so I'll  use the Faker BS names for now.
        category: Categories.random(transaction_id),
        counterparty: counter_party,
        processing_status: "complete"
      },
      links: gen_links(account_id, transaction_id),
      # From example in PDF this has a value but Teller's sandbox is returning nil
      running_balance: nil,
      status: if(days_ago == 0, do: "pending", else: "posted"),
      type: "card_payment"
    }
  end

  defp gen_id(seed), do: Id.new(["txn", seed])

  defp gen_counterparty(transaction_id) do
    rand = Randomizer.bounded_number(transaction_id, 10)

    type =
      cond do
        rand in [0, 1, 2, 3, 4, 5, 6] -> "organization"
        rand in [7, 8, 9, 10] -> "person"
      end

    name =
      if type == "organization",
        do: Name.merchant(transaction_id),
        else: Name.person(transaction_id)

    %{
      name: name,
      type: type
    }
  end

  defp gen_links(account_id, transaction_id) do
    %{
      account: "#{BasePath.base_endpoint()}/accounts/#{account_id}",
      self: "#{BasePath.base_endpoint()}/accounts/#{account_id}/transactions/#{transaction_id}"
    }
  end

  defp now_minus_days(days_ago) do
    Date.utc_today() |> Date.add(-days_ago) |> Date.to_iso8601()
  end

  defp gen_amount(transaction_id) do
    size = Random.randint(2, 3)

    Number.negative_amount(transaction_id, size)
  end
end
