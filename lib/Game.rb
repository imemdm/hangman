class Game
  attr_accessor :guesses

  def initialize(word, guesses)
    @word = word
    @guesses = guesses
  end

  def self.start
    puts "Game is starting..."
    if Save.has_saves?
      print "Load a saved game?(y/n) "
      self.from_json(Save.select_save).run if gets.chomp.downcase == "y"
    end
    puts "Random word selected."
    self.new(Word.new(Dict.random_word), 7).run
  end

  # Everything put toghether to play a single game
  def run
    until game_over?
      Guess.make(word)

      if guessed?
        at_exit { puts "You have guessed: '#{word}'" }
        exit
      end
      self.guesses -= 1
      puts "#{guesses} left"

      show_current_state
      save_prompt
    end
    at_exit { puts "The word was '#{word}' - YOU LOST" }
    exit
  end

  private

  attr_reader :word

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
      word: word.to_json,
      guesses: guesses
    })
  end

  def self.from_json(string)
    data = JSON.load(string)
    self.new(Word.from_json(data["word"]), data['guesses'])
  end

  # Logic to make a save after each turn
  def save_prompt
    print "Save the current progress?(y/n) "

    if gets.chomp.downcase == "y"
      Save.add(to_json)
      quit_prompt
    end
  end

  # Handles the logic to quit the game after a save
  def quit_prompt
    print "Quit?(y/n) "
    at_exit { puts "Thanks for playing!" }
    exit if gets.chomp.downcase == "y"
  end

  # Outputs some info after each turn
  def show_current_state
    puts "Word of length #{word.length} : #{word.pattern}"
    puts "Previous guesses: #{word.past_guesses.join(" ")}"
  end
end