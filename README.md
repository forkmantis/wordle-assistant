# Wordle Assistant #

## Overview ##

This script is intended to be run while you are playing wordle. It will ask you for the words you've guessed and the feedback that you get from wordle.  By entering 'x' for the letters not in the answer, 'y' (yellow) for the letters in a different position in the word, and 'g' for the letters in the correct position, wordle-assistant will filter the list of all possible solutions down to words that match the clues you've received.

I have done this manually via unix commands in the past, typically with something like the following for a word that contains a 'u' and 'f' in uknown positions.  I leverage the fact that I know where the 'u' and 'f' are not.

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

### MVP ###

* The dictionary is the same one used by wordle
* The assistant maintains the game state for multiple turns until the user has solved the wordle or run out of guesses
* The assistant asks for a word that has been guessed, and for the feedback received from the game.
* Each time the user submits data, the assistant will add the clues to the local game state, return a list of possible answers for the clues.
