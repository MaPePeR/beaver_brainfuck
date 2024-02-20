defmodule BeaverBrainfuckTest do
  use ExUnit.Case
  doctest BeaverBrainfuck

  test "greets the world" do
    assert BeaverBrainfuck.hello() == :world
  end
end
