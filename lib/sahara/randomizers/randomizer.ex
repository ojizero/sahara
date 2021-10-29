defmodule Sahara.Randomizer do
  @spec seed_number(iodata) :: integer
  def seed_number(seed) do
    :sha
    |> :crypto.hash(seed)
    |> Base.encode16()
    |> Integer.parse(16)
    |> elem(0)
  end

  @spec bounded_number(iodata, integer) :: integer
  def bounded_number(seed, upper) do
    seed
    |> seed_number()
    |> rem(upper + 1)
  end

  @spec random_alphanum() :: ?a..?z | ?0..?9 | ?A..?Z
  def random_alphanum do
    rand = Random.randint(0, 10)

    {start, stop} =
      cond do
        rand in [0, 1, 2, 3, 8, 9] -> {?a, ?z}
        rand in [4, 5, 6, 10] -> {?0, ?9}
        rand == 7 -> {?A, ?Z}
      end

    Random.randint(start, stop)
  end

  @spec random_digit() :: ?a..?z | ?0..?9 | ?A..?Z
  def random_digit do
    Random.randint(?0, ?9)
  end

  # Not sure of how bad this is to be done this way, but let's just do it for now

  @spec set_seed(iodata) :: :ok
  def set_seed(seed) do
    seed = seed_number(seed)
    old_seed = Random.seed(seed)

    if old_seed != :undefined do
      Process.put(:old_tinymt32_seed, old_seed)
    end

    :ok
  end

  @spec maybe_reset_seed :: :ok
  def maybe_reset_seed do
    old_seed = Process.delete(:old_tinymt32_seed)

    if not is_nil(old_seed), do: Process.put(:tinymt32_seed, old_seed)

    :ok
  end
end
