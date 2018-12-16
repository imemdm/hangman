require "json"

class Save
  FILE_NAME = "saves.json"

  def self.add(content)
    File.open(FILE_NAME, "a") { |fd| fd.puts(content) }
  end

  def self.load
    File.open(FILE_NAME, "r") { |fd| fd.readlines }
  end
end