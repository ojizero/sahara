defmodule Sahara.Randomizers.Name do
  import Sahara.Randomizer

  def person(seed) do
    set_seed(seed)

    name = Faker.Person.name()

    maybe_reset_seed()

    name
  end

  def merchant(seed) do
    set_seed(seed)

    name = Faker.Company.bs()

    maybe_reset_seed()

    name
  end

  def to_id(name) do
    name
    |> String.downcase()
    |> String.replace("-", "")
    |> String.replace(",", "")
    |> String.replace(".", "")
    |> String.replace(" ", "_")
  end
end
