defmodule WordsCounter do
  @moduledoc false

  @acc_starting_value 0
  @split_pattern ~r{(\\s|\\t|\\n|[^\w'])+}

  @doc """
  Counts the total number of words for a file in a given file path.
  Throws an exception if the file does not exist.
  It reduces the control symbols like `\n` and `\t`.
  Also, words with an apostrophe will be counted as one word.

  ## Examples

      iex> WordsCounter.count_words_for("./test/data/count_words_example.txt")
      20
  """
  @spec count_words_for(binary()) :: non_neg_integer()
  def count_words_for(file_path) do
    Enum.reduce(
      file_stream(file_path),
      @acc_starting_value,
      fn line, acc -> count_words_for(line, acc) end
    )
  end

  defp file_stream(file_path), do: File.stream!(Path.expand(file_path))

  defp count_words_for(line, acc) do
    line
    |> String.trim()
    |> String.split(@split_pattern)
    |> Enum.filter(&(&1 != ""))
    |> Enum.count()
    |> Kernel.+(acc)
  end
end
