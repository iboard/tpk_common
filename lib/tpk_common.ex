defmodule TPK.Common do
  @moduledoc """
  `TPK.Common` is a collection of 'globally' used pure functions.
  """

  def md_to_html!(md) do
    Earmark.as_html!(md)
  end
end
