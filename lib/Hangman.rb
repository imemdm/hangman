class Hangman
  def initialize(dict)
    @dict = dict
  end

  # Start the game by initiating a new Game object,
  # passing along a randomly generated word
  def self.start(dict)
    puts "Hangman is starting..."

    self.new(dict).menu
  end

  private

  def menu
    
  end

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

  def show_saves?
    print "Do you want to select a save from your library?(y/n) "

    gets.chomp.downcase == "y" ? true : false
  end

  def select_save
    puts "Select a save from the list by its number: "
    saves = Save.load
    saves.each_with_index { |save, i| puts i }
    saves[gets.chomp.to_i]
  end
end