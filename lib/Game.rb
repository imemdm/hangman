class Game
  def initialize(file_name)
    @file_name = file_name
  end

  def start
    random_word
  end

  private
  def load_dict
    File.readlines(@file_name, chomp: true)
  end

  def random_word
    valid_words = load_dict.find_all do |word| 
      word.length >= 5 && word.length <= 12
    end

    valid_words[rand(valid_words.length)]
  end
end