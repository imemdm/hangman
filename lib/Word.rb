class Word
  attr_reader :word

  def initialize(word, pattern = nil)
    @word = word.downcase
    @pattern = pattern || "_" * word.length
    @current_guess = nil
  end

  # Checks if the suggested letter occures in the word
  def has_letter?(letter)
    @word.match?(letter)
  end

  # Outputs the current state of the pattern in the console
  def output_pattern
    @pattern
  end

  # Finds and replaces empty chars in the pattern
  # with the correct letter
  def correct_letter(letter)
    poss = find_occurrences(letter)

    poss.each { |pos| @pattern[pos] = letter }
  end

  def guessed?(input)
    @pattern == @word || input == @word
  end

  def to_json
    JSON.dump({
      word: @word,
      pattern: @pattern
    })
  end

  def self.from_json(string)
    data = JSON.load(string)

    self.new(data["word"], data["pattern"])
  end

  private
  # Returns an array of positional indexes at which
  # the given letter occurrs
  def find_occurrences(letter)
    positions = []
    @word.split("").each_with_index do |el, idx|
      positions << idx if letter == el
    end

    positions
  end
end