defmodule BeaverBrainfuck.Dialect do
  require Beaver
  use Beaver.Slang, name: "brainfuck"

  defop move_left(), do: []
  defop move_right(), do: []
  defop increment(), do: []
  defop decrement(), do: []
  defop output(), do: []
  defop input(), do: []

  def compile_ast(ssa, ast) when ast != [] do
    [op | tail] = ast
    new_ssa = case op do
      {:move_left, _} -> BeaverBrainfuck.Dialect.move_left(ssa)
      {:move_right, _} -> BeaverBrainfuck.Dialect.move_right(ssa)
      {:increment, _} -> BeaverBrainfuck.Dialect.increment(ssa)
      {:decrement, _} -> BeaverBrainfuck.Dialect.decrement(ssa)
      {:output, _} -> BeaverBrainfuck.Dialect.output(ssa)
      {:input, _} -> BeaverBrainfuck.Dialect.input(ssa)
      _ -> IO.puts("Can't handle op")
        IO.inspect(op)
        ssa
      #{:block, inside_block} -> Beaver.MLIR.Dialect.SCF.while(ssa) ... compile_ast(inside_block)
    end
    compile_ast(new_ssa, tail)
  end
  def compile_ast(ssa, ast) when ast == [] do
    ssa
  end
end
