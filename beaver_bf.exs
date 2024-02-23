use Beaver

bf_code = case System.argv do
  [filename] -> File.read!(filename)
  [] -> case IO.read(:stdio, :eof) do
    :eof -> ""
    {:error, reason} -> raise "Cannot read from stdio #{reason}"
    data -> data
  end
end

{:ok, ast} = BeaverBrainfuck.code_to_ast(bf_code)
IO.inspect(ast)

alias Beaver.MLIR.Type
alias Beaver.MLIR.Dialect.Func
require Func
ctx = MLIR.Context.create()
alias Beaver.MLIR.Dialect.Arith
alias Beaver.MLIR.Attribute

Beaver.MLIR.CAPI.mlirContextSetAllowUnregisteredDialects(ctx, true) # How to register dialect properly?

ir =
  mlir ctx: ctx do
    module do
      Func.func main(function_type: Type.function([], [])) do
        region do
          block bb_entry() do
            # TODO: Setup Memory region
            idx = Arith.constant(value: Attribute.integer(Type.i32, 0)) >>> Type.i32()
            BeaverBrainfuck.Dialect.move_left() >>> []
            # TODO goto code.
          end

          block code() do
            BeaverBrainfuck.Dialect.compile_ast(ast)
          end
        end
      end
    end
  end

ir |> Beaver.MLIR.to_string() |> IO.puts()
