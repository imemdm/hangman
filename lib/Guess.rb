class Guess
  def initialize(word)
    @word = word
  end
  
  def self.make(word)
    guess = self.new(word)
    loop do
      print "Your guess: "
      break if guess.success?(gets.chomp.downcase)
    end
  end

  def success?(player_input)
    word.try(player_input)
  end

  private

  attr_reader :word
end