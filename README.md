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

### MVP ###

* The dictionary should contain 5 letter English words, but not proper nouns
* The assistant should maintain the game state for multiple turns until the user has solved the wordle or run out of guesses
* The assistant should print the green, yellow and black letters it knows about at the beginning of each round
* The assistant should ask for newly discovered green, yellow or black letters
* Each known green letter should also include information on its position
* Each known yellow letter should include information on the positions for which it is not used
* After the new information has been supplied by the user, the assistant should filter the dictionary and show all the potential solutions

### Enhancements ###

* The user can edit previously added letters in the event they made a mistake
