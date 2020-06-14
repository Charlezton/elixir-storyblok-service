defmodule SBSTest do
  use ExUnit.Case
  doctest SBC

  test "greets the world" do
    assert SBC.hello() == :world
  end
end
