defmodule Sahara.Randomizers.Id do
  import Sahara.Randomizer

  @spec new(iodata) :: binary
  def new([prefix | _rest] = seed) do
    set_seed(seed)

    # based on newly set seed we'll make a random string now of length 20~25
    length = Random.randint(20, 25)

    id = Enum.map(0..length, fn _i -> random_alphanum() end)

    maybe_reset_seed()

    :erlang.iolist_to_binary([prefix, ?_, id])
  end
end
