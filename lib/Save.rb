require "json"

class Save
  FILE_NAME = "saves.json"

  def create_save(content)
    File.open(FILE_NAME, "a") { |fd| fd.puts(content) }
  end
end