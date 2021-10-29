defmodule Sahara.Randomizers.Faker do
  @behaviour Faker.Random

  @impl Faker.Random
  def random_between(left, right) do
    Random.randint(left, right)
  end

  @impl Faker.Random
  def random_bytes(total) do
    1..total
    |> Enum.map(fn _ -> Sahara.Randomizer.random_alphanum() end)
    |> :erlang.iolist_to_binary()
  end

  @impl Faker.Random
  def random_uniform do
    Random.uniform(0, 1)
  end
end
