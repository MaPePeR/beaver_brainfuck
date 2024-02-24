defmodule BeaverBrainfuck do
  @moduledoc """
  Documentation for `BeaverBrainfuck`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> BeaverBrainfuck.hello()
      :world

  """
  def hello do
    :world
  end

  def lex_code_to_tokens(bf_code) do
    case :bf_lex.string(to_charlist(bf_code)) do
      {:ok, tokens, _} -> {:ok, tokens}
      other -> other
    end
  end

  def parse_tokens_to_ast(tokens) do
    :bf_parser.parse(tokens)
  end

  def code_to_ast(code) do
    with {:ok, tokens} <- lex_code_to_tokens(code),
         {:ok, ast} <- parse_tokens_to_ast(tokens) do
      {:ok, ast}
    end
  end

  def main(args \\ []) do
    bf_code =
      case args do
        [filename] ->
          File.read!(filename)

        [] ->
          case IO.read(:stdio, :eof) do
            :eof -> ""
            {:error, reason} -> raise "Cannot read from stdio #{reason}"
            data -> data
          end
      end

    ast = code_to_ast(bf_code)
    IO.inspect(ast)
  end
end
