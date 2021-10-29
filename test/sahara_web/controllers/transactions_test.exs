defmodule SaharaWeb.Controllers.TransactionsTest do
  use SaharaWeb.ConnCase

  @token "Basic " <> Base.encode64("test_token_JbSVJAsdlx007:")
  @another_token "Basic " <> Base.encode64("test_token_7bVt6p2GFx007:")

  test "it returns a list of transactions", %{conn: conn} do
    %{"id" => account_id} = conn |> list_accounts(@token) |> json_response(200) |> hd()
    resp = conn |> list_transactions(account_id, @token) |> json_response(200)
    resp_again = conn |> list_transactions(account_id, @token) |> json_response(200)

    assert is_list(resp), "must be a list of accounts"

    assert Enum.count(resp) ==
             resp |> Enum.uniq_by(fn txn -> Map.get(txn, "id") end) |> Enum.count(),
           "must be unique list of transactions by ID"

    assert resp == resp_again,
           "must not give different values per the same token"
  end

  test "it returns a different list of accounts by token", %{conn: conn} do
    %{"id" => first_account_id} = conn |> list_accounts(@token) |> json_response(200) |> hd()

    %{"id" => second_account_id} =
      conn |> list_accounts(@another_token) |> json_response(200) |> hd()

    resp = conn |> list_transactions(first_account_id, @token) |> json_response(200)

    resp_other_token =
      conn |> list_transactions(second_account_id, @another_token) |> json_response(200)

    assert is_list(resp), "must be a list of accounts"
    assert is_list(resp_other_token), "must be a list of accounts"

    assert resp != resp_other_token,
           "must give different values for different tokens"
  end

  test "it returns a single transaction with identical info if requested", %{conn: conn} do
    %{"id" => account_id} = conn |> list_accounts(@token) |> json_response(200) |> hd()

    transaction_from_index =
      conn |> list_transactions(account_id, @token) |> json_response(200) |> hd()

    transaction_from_show =
      conn
      |> show_transaction(account_id, transaction_from_index["id"], @token)
      |> json_response(200)

    assert transaction_from_index == transaction_from_show
  end

  test "it must fail to find the transactions if given a wrong token", %{conn: conn} do
    %{"id" => account_id} = conn |> list_accounts(@token) |> json_response(200) |> hd()

    assert %{
             "error" => %{
               "code" => "not_found",
               "message" => "The requested resource does not exist"
             }
           } =
             conn
             |> list_transactions(account_id, @another_token)
             |> json_response(404)
  end

  defp list_accounts(conn, authnz) do
    conn
    |> put_req_header("authorization", authnz)
    |> get(Routes.accounts_path(conn, :index))
  end

  defp list_transactions(conn, account_id, authnz) do
    conn
    |> put_req_header("authorization", authnz)
    |> get(Routes.transactions_path(conn, :index, account_id))
  end

  defp show_transaction(conn, account_id, transaction_id, authnz) do
    conn
    |> put_req_header("authorization", authnz)
    |> get(Routes.transactions_path(conn, :show, account_id, transaction_id))
  end
end
