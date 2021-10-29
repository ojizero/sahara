defmodule Sahara.Randomizers.Number do
  import Sahara.Randomizer

  @spec new(iodata) :: binary
  def new(seed, length \\ 10) do
    set_seed(seed)

    number = Enum.map(0..length, fn _i -> random_digit() end)

    maybe_reset_seed()

    :erlang.iolist_to_binary(number)
  end
end
