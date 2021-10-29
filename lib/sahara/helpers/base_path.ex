defmodule Sahara.Helpers.BasePath do
  def base_endpoint do
    Application.get_env(:sahara, :base_endpoint)
  end
end
