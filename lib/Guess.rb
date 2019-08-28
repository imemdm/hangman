class Guess
  def self.make(word)
    loop do
      print "Your guess: "

      break if guess_success(gets.chomp.downcase)
    end
  end

  def complete
    input = nil
    loop do 
      input = ask_for_input
      break if Helpers.valid_input?(input, @past_letters)
    end

    @past_letters << input if Helpers.valid_letter?(input, @past_letters)

    if @word.has_letter?(input)
      @word.correct_letter(input)
      show_correct_guess(input)
    end

    @word.guessed?(input)
  end

  private

end