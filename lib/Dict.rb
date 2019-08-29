class Dict
  FILE_NAME = "5desk.txt"

  # Selects a random valid word from the dict
  def self.random_word
    valid_words = self.load.find_all do |word| 
      self.valid_word?(word)
    end

    valid_words[rand(valid_words.length)]
  end

  def self.has_saves?
    File.exists?(FILE_NAME)
  end

  private

  attr_reader :dict

  def self.load
    File.readlines(FILE_NAME, chomp: true)
  end

  def self.valid_word?(word)
    word.length >= 5 && word.length <= 12
  end
end