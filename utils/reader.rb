class Reader
  def self.get_instructions(filename)
    whole_file = File.readlines filename
    whole_file
  end
end
