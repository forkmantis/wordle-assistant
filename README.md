# Wordle Assistant #

## Overview ##


This utility uses all of the 5 letter words of lower case only letters from the OS X dictionary found at /usr/share/dict/words

This is a command line utility that will show a list of possible matching words based on 3 groups of letters.  It will use letters that you know are not in the word, letters that you know are in the word, but do not know which position, and letters for which you do know the position.

I am not yet sure of the most user friendly way to get input from the user, so we'll start with whatever I can get to work, and refine it after I get an MVP working

I have done this manually via unix commands in the past, typically with something like the following:

```
cat /usr/share/dict/words | grep "^[^f][^fu][^f].[^u]$" | grep "f" | grep "u" | grep -v "[A-Zadiegnxclzy]"
```

I'll describe each command above, and how they work together:

* the cat command will send the entire contents of the dictionary to stdout
* the first grep uses ^ and $ to anchor to the beginning and end of the words, and takes a first pass at describing what we know about each of the 5 letters.
  * The first character is not an f.
  * The second character is not an f or u.
  * The third character is not an f.
  * We have no clues about the 4th character
  * The fifth character is not a u.
* The next two grep statements filter to words that contain both an f and a u.
* The final grep filters out words with any capital letter, as well as words with any of the letters that we know are not contained in the word.

## Acceptance Criteria ##

* The dictionary should not contain any proper nouns
* Filtering should accumulate, or be additive over successive guesses
* Upon each filtering, a list of all possible answers should be printed to stdout
