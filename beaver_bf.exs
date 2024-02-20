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
