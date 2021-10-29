defmodule SaharaWeb.Controllers.AccountsTest do
  use SaharaWeb.ConnCase

  @token "Basic " <> Base.encode64("test_token_JbSVJAsdlx007:")
  @another_token "Basic " <> Base.encode64("test_token_7bVt6p2GFx007:")

  describe "accounts listing" do
    test "it returns a list of accounts", %{conn: conn} do
      resp = conn |> list_accounts(@token) |> json_response(200)
      resp_again = conn |> list_accounts(@token) |> json_response(200)

      assert is_list(resp), "must be a list of accounts"

      assert Enum.count(resp) ==
               resp |> Enum.uniq_by(fn acnt -> Map.get(acnt, "id") end) |> Enum.count(),
             "must be unique list of accounts by ID"

      assert resp == resp_again,
             "must not give different values per the same token"
    end

    test "it returns a different list of accounts by token", %{conn: conn} do
      resp = conn |> list_accounts(@token) |> json_response(200)
      resp_other_token = conn |> list_accounts(@another_token) |> json_response(200)

      assert is_list(resp), "must be a list of accounts"
      assert is_list(resp_other_token), "must be a list of accounts"

      assert resp != resp_other_token,
             "must give different values for different tokens"
    end

    test "it returns a single account with identical info if requested", %{conn: conn} do
      account_from_index = conn |> list_accounts(@token) |> json_response(200) |> hd()

      account_from_show =
        conn |> show_account(account_from_index["id"], @token) |> json_response(200)

      assert account_from_index == account_from_show
    end

    test "it must fail to find the account if given a wrong token", %{conn: conn} do
      account_from_index = conn |> list_accounts(@token) |> json_response(200) |> hd()

      assert %{
               "error" => %{
                 "code" => "not_found",
                 "message" => "The requested resource does not exist"
               }
             } =
               conn
               |> show_account(account_from_index["id"], @another_token)
               |> json_response(404)
    end
  end

  describe "account details" do
    test "it returns details of a given accounts", %{conn: conn} do
      %{"id" => account_id} = conn |> list_accounts(@token) |> json_response(200) |> hd()

      assert %{"account_id" => ^account_id} =
               conn |> show_details(account_id, @token) |> json_response(200)
    end
  end

  describe "account balances" do
    test "it returns balances of a given accounts", %{conn: conn} do
      %{"id" => account_id} = conn |> list_accounts(@token) |> json_response(200) |> hd()

      assert %{"account_id" => ^account_id} =
               conn |> show_balances(account_id, @token) |> json_response(200)
    end
  end

  defp list_accounts(conn, authnz) do
    conn
    |> put_req_header("authorization", authnz)
    |> get(Routes.accounts_path(conn, :index))
  end

  defp show_account(conn, account_id, authnz) do
    conn
    |> put_req_header("authorization", authnz)
    |> get(Routes.accounts_path(conn, :show, account_id))
  end

  defp show_details(conn, account_id, authnz) do
    conn
    |> put_req_header("authorization", authnz)
    |> get(Routes.accounts_path(conn, :details, account_id))
  end

  defp show_balances(conn, account_id, authnz) do
    conn
    |> put_req_header("authorization", authnz)
    |> get(Routes.accounts_path(conn, :balances, account_id))
  end
end
