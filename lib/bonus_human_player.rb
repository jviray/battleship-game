class HumanPlayer
  attr_accessor :name, :board

  def initialize(name)
    @name = name
    @board = nil
  end

  def set_board
    print "#{@name}, would you like to set the board manually (Y/N)? "
    input = gets.chomp.downcase
    puts

    if input == "yes" || input == "y"
      @board = Board.new
    else
      @board = Board.random
    end

    puts "#{@name}'s board is SET!"
  end

  def get_play
    print "Input Coordinates: "
    coordinates = gets.chomp.split(", ").map do |coordinate|
      coordinate.to_i # must convert string
    end
  end
end
