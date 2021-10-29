defmodule Sahara.Randomizers.Number do
  import Sahara.Randomizer

  @spec new(iodata) :: binary
  def new(seed, length \\ 10) do
    set_seed(seed)

    number = Enum.map(1..length, fn _i -> random_digit() end)

    maybe_reset_seed()

    :erlang.iolist_to_binary(number)
  end

  def amount(seed, size) do
    whole_number = new(seed, size)

    fraction = new(seed, 2)

    "#{whole_number}.#{fraction}"
  end

  def negative_amount(seed, size) do
    "-#{amount(seed, size)}"
  end

  def ledger_amount(seed) do
    size = Random.randint(4, 5)

    amount(seed, size)
  end
end
