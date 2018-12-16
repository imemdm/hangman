require "./lib/Game"
require "./lib/Word"
require "./lib/Helpers"
require "./lib/Turn"
require "./lib/Save"
require "./lib/Hangman"

puts "Game is starting..."

hangman = Hangman.new("5desk.txt")
hangman.start

