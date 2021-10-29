defmodule Sahara.Seeds.Institutions do
  @names ["Chase", "Bank of America", "Wells Fargo", "Citibank", "Capital One"]

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

  def random(_seed), do: hd(@all)
end
