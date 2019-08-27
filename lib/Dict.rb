class Dict
  FILE_NAME = "5desk.txt"

  def initialize(dict)
    @dict = dict
  end

  # Selects a random valid word from the dict
  def self.random_word
    valid_words = self.load.find_all do |word| 
      Helpers.valid_word?(word)
    end

    valid_words[rand(valid_words.length)]
  end

  private

  attr_reader :dict

  def self.load
    dict = self.new(FILE_NAME)
    File.readlines(dict, chomp: true)
  end
end