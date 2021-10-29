defmodule SaharaWeb.Plugs.AuthTest do
  use ExUnit.Case, async: true
  use Plug.Test

  @unknown_token "Basic " <> Base.encode64("test_token_unknown:")
  @valid_prod_like_token "Basic " <> Base.encode64("prod_token_abc:")
  @valid_token "Basic " <> Base.encode64("test_token_JbSVJAsdlx007:")

  defmodule Hello do
    # need to use Phoenix.Controller because RateLimit.Plug uses ErrorView
    # which in turn requires `plug :accepts`
    use Phoenix.Controller

    plug :accepts, ~w(json)
    plug SaharaWeb.Plugs.Auth

    def index(conn, _params) do
      send_resp(conn, 200, "Hello, World!")
    end
  end

  test "it rejects invalid token types" do
    conn = request("abc")
    assert 400 = conn.status

    conn = request("Token abc")
    assert 400 = conn.status
  end

  test "it rejects unknown tokens or tokens from wrong environment" do
    conn = request(@unknown_token)
    assert 403 = conn.status

    conn = request(@valid_prod_like_token)
    assert 400 = conn.status
  end

  test "it accepts valid and known tokens" do
    conn = request(@valid_token)
    assert 200 = conn.status
  end

  defp request(authnz) do
    :get
    |> conn("/")
    |> put_req_header("authorization", authnz)
    |> Hello.call(:index)
  end
end
