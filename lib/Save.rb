require "json"

class Save
  FILE_NAME = "saves.json"

  def self.select_save
    puts "Select a save from the list by its number: "
    saves = self.load
    saves.each_with_index { |save, i| puts "#{i}: #{save['past_letters']}" }
    saves[gets.chomp.to_i]
  end

  def self.has_saves?
    File.exist?(FILE_NAME)
  end
  
  def self.add(content)
    File.open(FILE_NAME, "a") { |fd| fd.puts(content) }
  end
  
  private
  
  def self.load
    File.open(FILE_NAME, "r") { |fd| fd.readlines }
  end
end