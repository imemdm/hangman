class Guess
  def initialize(word)
    @word = word
  end

  def self.make(word)
    self.new(word)
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
  # Gets input from player
  def ask_for_input
    print "Make a guess: "
    gets.chomp.downcase
  end

  # Outputs the correct guess
  def show_correct_guess(letter)
    puts "You have guessed correctly: \"#{letter}\""
  end
end