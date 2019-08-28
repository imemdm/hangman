class Guess
  def initialize(word)
    @word = word
  end

  def self.make(word)
    loop do
      print "Your guess: "
      break if guess_success?(gets.chomp.downcase)
    end
  end

  private

  attr_reader :word

  def guess_success?(guess)
    word.try(guess)
  end
end