class Dict
  FILE_NAME = "5desk.txt"

  def initialize(dict)
    @dict = dict
  end

  def self.load
    dict = self.new(FILE_NAME)
    File.readlines(dict, chomp: true)
  end

  private

  attr_reader :dict
end