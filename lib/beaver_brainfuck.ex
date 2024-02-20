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

  def main(args \\ []) do
    bf_code = case args do
      [filename] -> File.read!(filename)
      [] -> case IO.read(:stdio, :eof) do
        :eof -> ""
        {:error, reason} -> raise "Cannot read from stdio #{reason}"
        data -> data
      end
    end
    {:ok, tokens, _} = :bf_lex.string(to_charlist(bf_code))
    IO.inspect(tokens)
    result = :bf_parser.parse(tokens)
    IO.inspect(result)
  end
end
