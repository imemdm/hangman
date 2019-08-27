class Game
  def initialize(word, past_letters, remaining_turns)
    @word = word
    @past_letters = past_letters
    @remaining_turns = remaining_turns
  end

  def start
    print "Load a saved game?(y/n) "
    show_saves = gets.chomp.downcase

    if show_saves == "y"
      save = select_save
      game = self.from_json(save).run
    else
      game = self.new(Word.new(random_word), [], 7).run
    end
  end

  # Everything put toghether to play a single game
  def run
    turns = @remaining_turns
    turns.times do |turn|
      puts "#{@remaining_turns = turns - turn} turns remaining"
      guessed = Turn.new(@word, @past_letters).complete
      Helpers.whitespace(1)

      if guessed
        Helpers.whitespace(1)
        at_exit { puts "You have guessed: '#{@word.word}'" }
        exit
      end

      show_current_state
      Helpers.whitespace(2)
      save
      Helpers.whitespace(2)
    end
    at_exit { puts "The word was '#{@word.word}' - YOU LOST" }
    exit
  end

  def to_json
    JSON.dump({
      word: @word.to_json,
      past_letters: @past_letters,
      remaining_turns: @remaining_turns
    })
  end

  def self.from_json(string)
    data = JSON.load(string)
    p data
    self.new(Word.from_json(data["word"]), data['past_letters'], data['remaining_turns'])
  end

  private
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