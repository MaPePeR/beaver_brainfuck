defmodule BeaverBrainfuck.Dialect do
  use Beaver
  use Beaver.Slang, name: "brainfuck"

  defop move_left(), do: []
  defop move_right(), do: []
  defop increment(), do: []
  defop decrement(), do: []
  defop output(), do: []
  defop input(), do: []
  defop block(), do: []

  def compile_ast([], _opts) do
    []
  end

  def compile_ast([op | tail], opts) do
    alias __MODULE__, as: BF

    mlir block: opts[:block], ctx: opts[:ctx] do
      case op do
        {:move_left, _} ->
          BF.move_left() >>> []

        {:move_right, _} ->
          BF.move_right() >>> []

        {:increment, _} ->
          BF.increment() >>> []

        {:decrement, _} ->
          BF.decrement() >>> []

        {:output, _} ->
          BF.output() >>> []

        {:input, _} ->
          BF.input() >>> []

        {:block, inside_block} ->
          BF.block [] do
            region do
              Beaver.block _loop() do
                BeaverBrainfuck.Dialect.compile_ast(inside_block,
                  block: Beaver.Env.block(),
                  ctx: Beaver.Env.context()
                )
              end
            end
          end >>> []

        _ ->
          IO.puts("Can't handle op")
          IO.inspect(op)
      end
    end

    compile_ast(tail, opts)
  end
end
