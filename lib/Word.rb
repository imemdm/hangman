class Word
  attr_accessor :pattern, :full_guess
  attr_reader :word

  def initialize(word, pattern = nil)
    @word = word.downcase
    @pattern = pattern || "_" * word.length
    @full_guess = nil
  end

  def try(guess)
    if valid?(guess)
      apply(guess) if valid_letter?(guess)
      self.full_guess = guess if valid_word?(guess)
      true
    end
  end

  def guessed?
    pattern == word || full_guess == word
  end

  def to_json
    JSON.dump({
      word: word,
      pattern: pattern
    })
  end

  def self.from_json(string)
    data = JSON.load(string)

    self.new(data["word"], data["pattern"])
  end

  private

  def apply(guess)
    occurrences(letter).each { |pos| self.pattern[pos] = letter }
  end

  def valid?(guess)
    valid_letter?(guess) || valid_word?(guess)
  end

  def valid_letter?(guess)
    ("a".."z").include?(guess) && !pattern.include?(guess)
  end

  def valid_word?(guess)
    pattern.length == guess.length
  end

  # Returns an array of positional indexes at which
  # the given letter occurrs
  def occurrences(letter)
    positions = []
    word.chars.each_with_index do |el, idx|
      positions << idx if letter == el
    end

    positions
  end
end