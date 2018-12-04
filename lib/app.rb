require "./lib/Game.rb"

print "What is your name? "
name = gets.chomp
puts "Game is starting..."

g = Game.new(name)
p g
