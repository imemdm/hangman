class Game
  def initialize(word, remaining_turns, past_letters)
    @word = word
    @remaining_turns = remaining_turns
    @past_letters = past_letters
  end

  # Everything put toghether to play a single game
  def run
    @remaining_turns.times do |turn|
      puts "#{@remaining_turns = @remaining_turns - turn} turns remaining"
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