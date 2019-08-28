class Guess
  def self.make(word)
    loop do
      print "Your guess: "
      break if self.guess_success?(gets.chomp.downcase)
    end
  end

  private

  def self.guess_success?(guess)
    word.try(guess)
  end
end