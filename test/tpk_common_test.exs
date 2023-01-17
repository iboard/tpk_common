defmodule TpkCommonTest do
  use ExUnit.Case
  doctest TpkCommon

  test "module exists" do
    assert is_list( TpkCommon.__info__(:functions))
  end
end
