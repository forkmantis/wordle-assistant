DICTIONARY_FILE = "./resources/dictionary.txt"

words = File.readlines(DICTIONARY_FILE)

words.each {|word| puts word }

solved = false

while !solved
  puts "Have you solved the puzzle? (y/n)"
  solved = gets.chomp[0].match(/[Yy]/)
  puts "OK. Try again"
end

puts "Congratulations!"
