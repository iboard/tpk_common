defmodule TPK.Common.HTML do
  @doc ~s"""
  Convert a binary to an HTML-string. 
  nil-values are converted to an empty string.

  ### Examples: 

      iex> TPK.Common.HTML.md_to_html!()
      ""

      iex> TPK.Common.HTML.md_to_html!("")
      ""

      iex> TPK.Common.HTML.md_to_html!("# Header")
      "<h1>\\nHeader</h1>\\n"
  """
  def md_to_html!(md_or_nil \\ nil)
  def md_to_html!(nil), do: ""

  def md_to_html!(md) do
    Earmark.as_html!(md)
  end

  @doc ~s"""
  Read markdown from a given file and return an HTML-string. 

  ### Example 

       iex> TPK.Common.HTML.md_file_to_html!("LICENSE.md") |> String.contains?("APACHE")
       true

  """
  def md_file_to_html!(md_or_nil \\ nil)
  def md_file_to_html!(nil), do: ""

  def md_file_to_html!(filename) do
    with {:ok, content} <- File.read(filename),
         {:ok, html, _} <- Earmark.as_html(content) do
      html
    else
      error -> "ERROR: #{inspect(error, pretty: true)}"
    end
  end
end
