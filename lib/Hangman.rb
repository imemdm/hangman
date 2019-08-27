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



  def show_saves?
    print "Do you want to select a save from your library?(y/n) "

    gets.chomp.downcase == "y" ? true : false
  end


end