defmodule BeaverBrainfuck.Dialect do
  use Beaver
  use Beaver.Slang, name: "brainfuck"

  defop move_left(), do: []
  defop move_right(), do: []
  defop increment(), do: []
  defop decrement(), do: []
  defop output(), do: []
  defop input(), do: []

  def compile_ast([], _opts) do
    []
  end

  def compile_ast([op | tail], opts) do
    mlir block: opts[:block], ctx: opts[:ctx] do
      case op do
        {:move_left, _} ->
          BeaverBrainfuck.Dialect.move_left() >>> []

        {:move_right, _} ->
          BeaverBrainfuck.Dialect.move_right() >>> []

        {:increment, _} ->
          BeaverBrainfuck.Dialect.increment() >>> []

        {:decrement, _} ->
          BeaverBrainfuck.Dialect.decrement() >>> []

        {:output, _} ->
          BeaverBrainfuck.Dialect.output() >>> []

        {:input, _} ->
          BeaverBrainfuck.Dialect.input() >>> []

        _ ->
          IO.puts("Can't handle op")
          IO.inspect(op)

          # {:block, inside_block} -> Beaver.MLIR.Dialect.SCF.while(ssa) ... compile_ast(inside_block)
      end
    end

    compile_ast(tail, opts)
  end
end
