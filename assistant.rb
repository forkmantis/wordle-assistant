DICTIONARY_FILE = "./resources/dictionary.txt"

words = File.readlines(DICTIONARY_FILE)

words.each {|word| puts word }
