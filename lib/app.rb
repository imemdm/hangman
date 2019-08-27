require "./lib/Game"
require "./lib/Word"
require "./lib/Helpers"
require "./lib/Turn"
require "./lib/Save"
require "./lib/Hangman"

DICT = "5desk.txt"

puts "Game is starting..."

Hangman.start(DICT)


