defmodule Gateway.Infra.HttpClient do
  @moduledoc """
  Simple HTTP client wrapper.
  """

  def post(url, body, headers) do
    headers = normalize_headers(headers)

    Req.post(url,
      json: body,
      headers: headers
    )
  end

  def get(url, headers) do
    headers = normalize_headers(headers)

    Req.get(url,
      headers: headers
    )
  end

  defp normalize_headers(headers) when is_list(headers) do
    Enum.map(headers, fn
      {key, val} when is_binary(key) -> {key, val}
      {key, val} when is_atom(key) -> {Atom.to_string(key), val}
    end)
  end
end
