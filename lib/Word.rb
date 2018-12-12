class Word
  attr_reader :word

  def initialize(word)
    @word = word.downcase
    @pattern = "_" * word.length
  end

  # If the input was a single letter it delegates to a method
  # to handle that. It's possible for the player to try to
  # guess the whole word at once. In both cases it goes 
  # to a method that checks if the word has been guessed
  def guess(input)
    if input.length == 1
      handle_letter_input(input)
      word_guessed?
    else
      word_guessed?(input)
    end
  end
  
  # Outputs the current state of the pattern in the console
  def output_pattern
    @pattern
  end

  private

  def handle_letter_input(letter)
    unless has_letter?(letter)
      output_wrong_guess(letter)
      return
    end

    poss = find_occurrences(letter)

    poss.each { |pos| @pattern[pos] = letter }
  end

  def word_guessed?(input = nil)
    if input.nil?
      @pattern == @word
    else
      input == @word
    end
  end

  # Checks if the suggested letter occures in the word
  def has_letter?(letter)
    @word.match?(letter)
  end

  # Returns an array of positional indexes at which
  # the given letter occurrs
  def find_occurrences(letter)
    positions = []
    @word.split("").each_with_index do |el, idx|
      positions << idx if letter == el
    end

    positions
  end

  def output_wrong_guess(let)
    puts "No #{let} in the word"
  end
end