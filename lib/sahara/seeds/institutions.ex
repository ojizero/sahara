defmodule Sahara.Seeds.Institutions do
  alias Sahara.Randomizer

  @names ["Chase", "Bank of America", "Wells Fargo", "Citibank", "Capital One"]
  @count_bound length(@names) - 1

  @all Enum.map(@names, fn name ->
         %{
           name: name,
           id:
             name
             |> String.replace(" ", "_")
             |> String.downcase()
         }
       end)

  def all, do: @all

  def random(seed) do
    index = Randomizer.bounded_number(seed, @count_bound)

    Enum.at(@all, index)
  end
end
