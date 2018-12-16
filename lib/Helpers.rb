class Helpers
  @@alphabet = ("a".."z").to_a
  
  # Checks if the given input is a valid word through its length
  def self.valid_word?(input)
    input.length >= 5 && input.length <= 12
  end

  # Valid input is either a single letter or a
  # n entire valid word
  def self.valid_letter?(input, past_letters)
    @@alphabet.include?(input) && !past_letters.include?(input)
  end

  # Checks if the input is either a valid letter or a word
  def self.valid_input?(input, past_letters)
    self.valid_word?(input) || self.valid_letter?(input, past_letters)
  end

  # Adds n blank rows
  def self.whitespace(n)
    puts "\n" * n
  end
end