defmodule WordsCounter do
  @moduledoc """
  Both implemented methods count the total number of words
  for a file in a given file path, throw an exception if
  the file does not exist, reduce some symbols by the given
  pattern and rely on the rule that words with an apostrophe
  will be counted as one word.
  """

  @behaviour WordsCounter.Behaviour

  @acc_starting_value 0
  @split_pattern ~r{(\\s|\\t|\\n|[^\w'])+}

  @doc """
  Lazy implementation.

  ## Example

      iex> WordsCounter.lazy_count_words_for("./test/data/count_words_example.txt")
      %{:words_for_file => 20}
  """

  @impl WordsCounter.Behaviour
  def lazy_count_words_for(file_path) do
    file_stream(file_path)
    |> Enum.reduce(
      @acc_starting_value,
      fn line, acc -> count_words_for(line) + acc end
    )
    |> result()
  end

  @doc """
  Flowy implementation.

  ## Example

      iex> WordsCounter.flowy_count_words_for("./test/data/count_words_example.txt")
      %{:words_for_file => 20}
  """

  @impl WordsCounter.Behaviour
  def flowy_count_words_for(file_path) do
    file_stream(file_path)
    |> Flow.from_enumerable(max_demand: 20, stages: 8)
    |> Flow.partition(max_demand: 10, stages: 8, window: Flow.Window.count(10))
    |> Flow.reduce(fn -> [] end, fn line, acc -> [count_words_for(line) | acc] end)
    |> Enum.reduce(@acc_starting_value, &(&1 + &2))
    |> result()
  end

  defp file_stream(file_path), do: File.stream!(Path.expand(file_path))

  defp count_words_for(line) do
    line
    |> String.trim()
    |> String.split(@split_pattern)
    |> Enum.filter(&(&1 != ""))
    |> Enum.count()
  end

  defp result(number), do: %{words_for_file: number}
end
