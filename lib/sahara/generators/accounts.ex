defmodule Sahara.Generators.Accounts do
  alias Sahara.Generators.Account

  def all(seed) do
    # 1. from seed get random number of accounts
    # 2. pass seed to account generator along with index and get random stream from there

    [Account.new(seed)]
  end
end
