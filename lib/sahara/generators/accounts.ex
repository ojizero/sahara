defmodule Sahara.Generators.Accounts do
  alias Sahara.Generators.Account

  def all(seed) do
    accounts_count = Sahara.Randomizer.bounded_number(seed, 10)

    Enum.map(
      0..accounts_count,
      fn i -> Account.new([seed, i]) end
    )
  end
end
