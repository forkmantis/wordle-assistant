# this utility will help a user guess a 5 letter word that is unknown to this program.  The user will input the word they guessed, and the feedback they received about each letter in the word.  The feedback will tell the user each letter they guessed that is in the word and in the right position, each letter in the word but in a different position, and each letter they guessed that is not in the word.  This program will take those clues and filter the dictionary to find words that match the clues. Until the user solves the puzzle or exhausts their 6  guesses, the program will continue to ask the user to guess a word, and collect the feedback about their new guess.  On each iteration, the program will filter the dictionary based on the new clues and present the user with a new list of potential answers.  The program will maintain a state of all the clues for the duration of it's run.

# Create a game state to keep track of the clues.  The game state will be a hash with the following keys: words_guessed, letters_in_correct_position, letters_in_wrong_position, letters_not_in_word.  The values for each key will be an array of strings.  The words_guessed key will be an array of strings.  The letters_in_correct_position key will be an array of hashes with the letter and it's position (0-4).  The letters_in_wrong_position key will be an array of hashes with the letter and an array of positions it does not belong in (0-4).

DICTIONARY_FILE = "./resources/dictionary.txt"

words = File.readlines(DICTIONARY_FILE)

class GameState
  attr_accessor :words_guessed, :letters_in_correct_position, :letters_in_wrong_position, :letters_not_in_word

  def initialize
    @words_guessed = []
    @letters_in_correct_position = {0 => ".", 1 => ".", 2 => ".", 3 => ".", 4 => "."}
    @letters_in_wrong_position = {0 => [], 1 => [], 2 => [], 3 => [], 4 => []}
    @letters_not_in_word = []
  end
end

puts "Welcome to the wordle assistant!"

# Game loop will ask the user what word they guessed, and for the for each letter, whether it is in the word and in the correct position, in the word but in a different position, or not in the word at all.

finished = false  # This will be set to true when the user solves the puzzle or runs out of guesses.
game_state = GameState.new

while !finished
  puts "What 5 letter word did you guess?"
  word_guessed = gets.chomp.downcase
  puts "What feedback did you get ('x' for letters not in word, 'g' for letters in the right position, 'y' for letters in the wrong position)?"
  puts "Example feedback: xgxyy"
  feedback = gets.chomp.downcase

  # for each character of feedback, update the game state with the corresponding character in the word_guessed
  for i in 0..4
    case feedback[i]
    when 'x'
      # add the letter to the letters_not_in_word array if it is not already there
      if !game_state.letters_not_in_word.include?(word_guessed[i])
        game_state.letters_not_in_word << word_guessed[i]
      end
    when 'g'
      # update the letters_in_correct_position hash using the position as the key and the letter as the value
      game_state.letters_in_correct_position[i] = word_guessed[i]
    when 'y'
      # update the letters_in_wrong_position hash using the position as the key and adding the letter to the array if it is not already there
      if !game_state.letters_in_wrong_position[i].include?(word_guessed[i])
        game_state.letters_in_wrong_position[i] << word_guessed[i]
      end
    end
  end

  # print GameState
  puts "Game State:"
  puts "Words Guessed: #{game_state.words_guessed}"
  puts "Letters in correct position: #{game_state.letters_in_correct_position}"
  puts "Letters in wrong position: #{game_state.letters_in_wrong_position}"
  puts "Letters not in word: #{game_state.letters_not_in_word}"


  puts "Here are the words that match your clues:"
  # filter the dictionary to exclude words containing letters not in the word_guessed
  filtered_words = words.select { |word| word[/[^#{game_state.letters_not_in_word.join}]/] }
  # filter filtered_words to only include words that contain letters in the correct position
  filtered_words = filtered_words.select { |word| word[/#{game_state.letters_in_correct_position.values.join}/] }

  filtered_words.each { |word| puts word }

  puts "Do you want to guess another word? (y/n)"
  finished = gets.chomp.downcase == 'n'
end  # end of while true
