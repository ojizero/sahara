defmodule Sahara.Generators.Accounts do
  alias Sahara.Generators.Account

  def all(seed) do
    # Ensure it never zeroes out by always adding 1
    accounts_count = Sahara.Randomizer.bounded_number(seed, 4) + 1

    Enum.map(
      0..accounts_count,
      fn i -> Account.new([seed, i]) end
    )
  end
end
