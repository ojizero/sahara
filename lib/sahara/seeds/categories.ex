defmodule Sahara.Seeds.Categories do
  alias Sahara.Randomizer

  @all [
    "accommodation",
    "advertising",
    "bar",
    "charity",
    "clothing",
    "dining",
    "education",
    "electronics",
    "entertainment",
    "fuel",
    "groceries",
    "health",
    "home",
    "income",
    "insurance",
    "investment",
    "loan",
    "office",
    "phone",
    "service",
    "shopping",
    "software",
    "sport",
    "tax",
    "transport",
    "transportation",
    "utilities"
  ]
  @count length(@all) - 1

  def all, do: @all

  def random(seed) do
    index = Randomizer.bounded_number(seed, @count)

    Enum.at(@all, index)
  end
end
