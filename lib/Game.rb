class Game
  def initialize(word, past_letters, guesses)
    @word = word
    @past_letters = past_letters
    @guesses = guesses
  end

  def self.start
    print "Load a saved game?(y/n) "

    if gets.chomp.downcase == "y"
      save = Save.select_save
      self.from_json(save).run
    else
      self.new(Word.new(Dict.random_word), [], 7).run
    end
  end

  private

  attr_reader :guesses, :word, :past_letters

  # Everything put toghether to play a single game
  def run
    until game_over?
      Guess.make(word, past_letters)

      if guessed?
        at_exit { puts "You have guessed: '#{@word.word}'" }
        exit
      end
      self.guesses -= 1
      
      show_current_state
      save
    end
    at_exit { puts "The word was '#{@word.word}' - YOU LOST" }
    exit
  end

  def game_over?
    guessed? || ended?
  end

  def guessed?
    word.guessed?
  end

  def ended?
    guesses == 0
  end

  def to_json
    JSON.dump({
      word: @word.to_json,
      past_letters: @past_letters,
      guesses: @guesses
    })
  end

  def self.from_json(string)
    data = JSON.load(string)
    self.new(Word.from_json(data["word"]), data['past_letters'], data['guesses'])
  end

  # Logic to make a save after each turn
  def save
    print "Do you want to save the game?(y/n) "
    make_save = gets.chomp.downcase

    if make_save == "y"
      Save.add(self.to_json)
      quit
    end
  end

  # Handles the logic to quit the game after a save
  def quit
    print "Do you want to quit the game?(y/n) "
    quit = gets.chomp.downcase
    at_exit { puts "Thanks for playing!" }
    exit if quit == "y"
  end

  # Outputs some info after each turn
  def show_current_state
    puts "Word of length #{@word.word.length} : #{@word.output_pattern}"
    print "Previous guesses: "
    @past_letters.each { |letter| print " #{letter}" }
  end
end