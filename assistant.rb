# this utility will help a user guess a 5 letter word that is unknown to this program.  The user will input the word they guessed, and the feedback they received about each letter in the word.  The feedback will tell the user each letter they guessed that is in the word and in the right position, each letter in the word but in a different position, and each letter they guessed that is not in the word.  This program will take those clues and filter the dictionary to find words that match the clues. Until the user solves the puzzle or exhausts their 6  guesses, the program will continue to ask the user to guess a word, and collect the feedback about their new guess.  On each iteration, the program will filter the dictionary based on the new clues and present the user with a new list of potential answers.  The program will maintain a state of all the clues for the duration of it's run.

# Create a game state to keep track of the clues.  The game state will be a hash with the following keys: words_guessed, letters_in_correct_position, letters_in_wrong_position, letters_not_in_word.  The values for each key will be an array of strings.  The words_guessed key will be an array of strings.  The letters_in_correct_position key will be an array of hashes with the letter and it's position (0-4).  The letters_in_wrong_position key will be an array of hashes with the letter and an array of positions it does not belong in (0-4). 

DICTIONARY_FILE = "./resources/dictionary.txt"

words = File.readlines(DICTIONARY_FILE)

class GameState
  attr_accessor :words_guessed, :letters_in_correct_position, :letters_in_wrong_position, :letters_not_in_word

  def initialize
    @words_guessed = []
    @letters_in_correct_position = []
    @letters_in_wrong_position = []
    @letters_not_in_word = []
  end
end 

puts "Welcome to the wordle assistant!"

# Game loop will ask the user what word they guessed, and for the for each letter, whether it is in the word and in the correct position, in the word but in a different position, or not in the word at all.

while true
  game_state = GameState.new
  puts "Please enter a word to guess:"
  word_to_guess = gets.chomp.downcase
  puts "Please enter the feedback for each letter in the word:"
  word_to_guess.split("").each do |letter|
    puts "Letter: #{letter}"
    puts "Is it in the word? (y/n)"
    is_in_word = gets.chomp.downcase
    puts "Is it in the correct position? (y/n)"
    is_in_correct_position = gets.chomp.downcase
    if is_in_word == "y"
      if is_in_correct_position == "y"
        game_state[:letters_in_correct_position] << {letter: letter, position: 0}
      else
        game_state[:letters_in_wrong_position] << {letter: letter, position: 0}
      end
    else
      game_state[:letters_not_in_word] << letter
    end
  end
  puts "Here are the words that match your clues:"
  puts words.select { |word| word.downcase.include?(word_to_guess) }
end  # end of while true 