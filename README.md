# WordsCounter [![CI](https://github.com/georgiybykov/words_counter/actions/workflows/ci.yml/badge.svg)](https://github.com/georgiybykov/words_counter/actions)

Both implemented methods count the total number of words for a file in a given file path, throw an exception if the file does not exist, reduce some symbols by the given pattern and rely on the rule that words with an apostrophe will be counted as one word.

**Examples:**
``` elixir

    iex> WordsCounter.lazy_count_words_for("./test/data/count_words_example.txt")
    20

    iex> WordsCounter.flowy_count_words_for("./test/data/count_words_example.txt")
    20
```

**Includes:**
 - linter;
 - type checking;
 - tests;
 - configured GitHub Actions.
