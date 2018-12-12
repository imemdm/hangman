class Game
  @@alphabet = ("a".."z").to_a

  def initialize(file_name)
    @file_name = file_name
    @word = Word.new(random_word)
    @past_letters = []
  end

  def start
    handle_rounds(7)
  end

  private
  def handle_rounds(rds)
    result = false
    rds.times do |r|
      result = round
      rounds_left(rds, r)
      break if result
    end
    if result
      show_winning_message
    else
      show_lost_message
    end
  end

  def round
    show_current_state
    input = ""
    loop do
      ask_for_input
      input = gets.chomp.downcase
      break if valid_letter?(input) || valid_word?(input)
    end
    
    @past_letters << input if valid_letter?(input)

    @word.guess(input)
  end

  def ask_for_input
    print "Make a guess: "
  end

  def show_current_state
    puts "\n\n"
    puts "Word: #{@word.output_pattern} Length: #{@word.word.length}"
    print "Previous guesses: "
    @past_letters.each { |letter| print " #{letter}" }
    puts "\n"
  end

  def rounds_left(total, current)
    puts "Tries left: #{total - (current + 1)}"
  end

  # Valid input is either a single letter or a
  # n entire valid word
  def valid_letter?(input)
    @@alphabet.include?(input) && !@past_letters.include?(input)
  end

  # Checks if the given input is a valid word through its length
  def valid_word?(input)
    input.length >= 5 && input.length <= 12
  end

  # Returns an array containing all words from the given dict
  def load_dict
    File.readlines(@file_name, chomp: true)
  end

  # Selects a random valid word from the dict
  def random_word
    valid_words = load_dict.find_all do |word| 
      valid_word?(word)
    end

    valid_words[rand(valid_words.length)]
  end

  def show_winning_message
    puts "You have guessed the word #{@word.word}"
  end

  def show_lost_message
    puts "You LOST! The word was #{@word.word}"
  end
end