require "./lib/Hangman"
require "./lib/Game"
require "./lib/Word"
require "./lib/Save"
require "./lib/Helpers"
require "./lib/Turn"

puts "Game is starting..."

hangman = Hangman.new("5desk.txt")
hangman.start

