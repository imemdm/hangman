require "./lib/Game.rb"
require "./lib/Word.rb"
require "./lib/Save.rb"

puts "Game is starting..."

g = Game.new("5desk.txt")
g.start

