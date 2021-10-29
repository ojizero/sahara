defmodule SaharaWeb.Plugs.Auth do
  import Plug.Conn

  @accepted_tokens [
    "test_token_ieunxpma6pxnk",
    "test_token_MHCqhbYKsc007",
    "test_token_JbSVJAsdlx007",
    "test_token_d28ilZPYNX007",
    "test_token_7bVt6p2GFx007",
    "test_token_0d1fuvoiXw007",
    "test_token_DhpxehcVtQ007",
    "test_token_K6YyTrbyLj007",
    "test_token_fJlkFXvxTb007",
    "test_token_b2wQYopiPJ007",
    "test_token_OOwCryiOCu007",
    "test_token_Qn7nw0iY6P007",
    "test_token_IEvbInvmje007",
    "test_token_A5zZ87JXy5007"
  ]

  def init(opts), do: opts

  @spec call(Plug.Conn.t(), any) :: Plug.Conn.t()
  def call(%Plug.Conn{} = conn, _params) do
    with ["Basic " <> token] <- get_req_header(conn, "authorization"),
         {:ok, "test_" <> _token = token} <- Base.decode64(token),
         [token, ""] <- String.split(token, ":", parts: 2),
         {:authorized, true} <- {:authorized, token in @accepted_tokens} do
      assign(conn, :seed, token)
    else
      {:authorized, false} -> forbidden(conn)
      _else -> missing_auth(conn)
    end
  end

  defp forbidden(conn) do
    response =
      Phoenix.json_library().encode_to_iodata!(%{
        error: %{
          message: "Authorization token invalid",
          code: "forbidden"
        }
      })

    conn
    |> put_status(403)
    |> put_resp_content_type("application/json")
    |> resp(403, response)
    |> halt()
  end

  defp missing_auth(conn) do
    response =
      Phoenix.json_library().encode_to_iodata!(%{
        error: %{
          message: "Missing certificate: Retry request using your Teller client certificate.",
          code: "bad_request"
        }
      })

    conn
    |> put_status(400)
    |> put_resp_content_type("application/json")
    |> resp(400, response)
    |> halt()
  end
end
