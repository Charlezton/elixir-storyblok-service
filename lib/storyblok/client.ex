defmodule Storyblok.Client do
  use HTTPoison.Base
  import Poison

  @host Application.fetch_env!(:sbs, :host)
  @api_token Application.fetch_env!(:sbs, :api_token)
  @storyblok_resource_endpoint Application.fetch_env!(:sbs, :storyblok_resource_endpoint)

  def get_specialists do
    url = "#{@host}#{@storyblok_resource_endpoint}"
    headers = [{"Accept", "application/json"}]
    params = [{:token, @api_token}]

    case make_get_request(url, headers, [{:params, params}]) do
      {200, raw_body} -> parse_specialist_data(raw_body)
      {_, reason} -> {:error, "Error: #{reason}"}
    end
  end

  defp make_get_request(url, headers, options) do
    case get(url, headers, options) do
      {:ok, %{body: raw_body, status_code: code}} -> {code, raw_body}
      {:error, %{reason: reason}} -> {:error, "Failed at GET request: #{reason}"}
    end
  end

  defp parse_specialist_data(raw_data) do
    case decode(raw_data) do
      {:ok, data} ->
        %{"story" => %{"content" => %{"body" => body}}} = data

        %{"cards" => specialists} =
          Enum.find(body, fn element -> element["component"] == "card container" end)

        {:ok, specialists}

      {:error, _} ->
        {:error, "Failed at parsing data"}
    end
  end
end
