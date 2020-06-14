defmodule MinimalServer.Router do
  use Plug.Router

  plug(:match)
  plug(:dispatch)

  get("/specialists") do
    case Storyblok.Client.get_specialists() do
      {:ok, specialists} ->
        response = %{specialists: specialists}

        conn
        |> put_resp_content_type("application/json")
        |> put_resp_header("Access-Control-Allow-Origin", "*")
        |> send_resp(200, Poison.encode!(response))

      {:error, reason} ->
        IO.puts("Error: #{reason}")
        send_resp(conn, 500, "Internal server error!")
    end
  end

  match(_) do
    send_resp(conn, 404, "Requested page not found!")
  end
end
