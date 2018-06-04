class HumanPlayer
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def get_play
    print "Input Coordinates: "
    coordinates = gets.chomp.split(", ").map do |coordinate|
      coordinate.to_i # must convert string
    end
  end
end
