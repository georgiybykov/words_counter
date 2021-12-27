defmodule WordsCounter.Behaviour do
  @moduledoc """
  Behaviour for WordsCounter
  """

  @typedoc "Words counter"
  @type words_count() :: %{:words_for_file => non_neg_integer()}

  @callback lazy_count_words_for(binary()) :: words_count()
  @callback flowy_count_words_for(binary()) :: words_count()
end
