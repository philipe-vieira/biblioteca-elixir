defmodule BiblTest do
  use ExUnit.Case
  doctest Bibl

  test "greets the world" do
    assert Bibl.hello() == :world
  end
end
