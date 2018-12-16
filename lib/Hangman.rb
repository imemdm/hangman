class Hangman
  def initialize(dict)
    @dict = dict
  end

  # Start the game by initiating a new Game object,
  # passing along a randomly generated word
  def start
    Save.load
    game = Game.new(Word.new(random_word), 7, [])
    game.run
  end

  private
  # Returns an array containing all words from the given dict
  def load_dict
    File.readlines(@dict, chomp: true)
  end

  # Selects a random valid word from the dict
  def random_word
    valid_words = load_dict.find_all do |word| 
      Helpers.valid_word?(word)
    end

    valid_words[rand(valid_words.length)]
  end
end