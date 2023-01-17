defmodule TpkCommonTest do
  use ExUnit.Case
  doctest TPK.Common

  test "module exists" do
    assert is_list( TPK.Common.__info__(:functions))
  end
end
