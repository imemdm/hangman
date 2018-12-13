require "json"

class Save
  DIR_NAME = "saves"
  @@save_counter = 0

  def initialize
    Dir.mkdir(DIR_NAME) unless File.exists?(DIR_NAME)
  end

  def create_save(content)
    file_name = "#{DIR_NAME}/#{@@save_counter}_save.json"
    @@save_counter += 1

    File.open(file_name, "w") { |fd| fd.write(content) }
  end
end