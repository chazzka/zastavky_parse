defmodule ParseTest do
  use ExUnit.Case
  doctest Parse

  test "greets the world" do
    assert Parse.hello() == :world
  end
end
