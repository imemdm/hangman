class Word
  attr_accessor :pattern, :full_guess
  attr_reader :word :past_guesses

  def initialize(word, pattern = nil, past_guesses = nil)
    @word = word.downcase
    @pattern = pattern || "_" * word.length
    @past_guesses = past_guesses || []
    @full_guess = nil
  end

  def try(guess)
    if valid?(guess)
      apply(guess) if valid_letter?(guess)
      self.full_guess = guess if valid_word?(guess)
      past_guesses << guess
      true
    end
  end

  def guessed?
    pattern == word || full_guess == word
  end

  def to_s
    "#{word}"
  end

  def length
    word.length
  end

  def to_json
    JSON.dump({
      word: word,
      pattern: pattern,
      past_guesses: past_guesses
    })
  end

  def self.from_json(string)
    data = JSON.load(string)

    self.new(data["word"], data["pattern"], data["past_guesses"])
  end

  private

  def apply(letter)
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