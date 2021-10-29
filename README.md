# Sahara

To start sandbox API:

  * Install dependencies with `mix deps.get`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Available APIs

```
  GET /accounts
  GET /accounts/:account_id
  GET /accounts/:account_id/details
  GET /accounts/:account_id/balances
  GET /accounts/:account_id/transactions
  GET /accounts/:account_id/transactions/:transaction_id
```

Find the Paw file in the project root for sample of usage.

## Authentication

You must authenticate yourself using Basic auth mechanism and using one of the accepted tokens listed here,

  - `test_token_ieunxpma6pxnk`
  - `test_token_MHCqhbYKsc007`
  - `test_token_JbSVJAsdlx007`
  - `test_token_d28ilZPYNX007`
  - `test_token_7bVt6p2GFx007`
  - `test_token_0d1fuvoiXw007`
  - `test_token_DhpxehcVtQ007`
  - `test_token_K6YyTrbyLj007`
  - `test_token_fJlkFXvxTb007`
  - `test_token_b2wQYopiPJ007`
  - `test_token_OOwCryiOCu007`
  - `test_token_Qn7nw0iY6P007`
  - `test_token_IEvbInvmje007`
  - `test_token_A5zZ87JXy5007`

The token **must be** provided in the username field of basic auth token, while the password field **must** be left empty. The generated token **must** be provided in the `Authorization` header with the type `Basic` given to it.
