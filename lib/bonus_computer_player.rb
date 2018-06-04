class ComputerPlayer
  attr_accessor :name, :board

  def initialize(name)
    @name = name
    @board = nil
    @attack_history = []
  end

  def set_board
    @board = Board.random
    puts "#{@name}'s board is SET!"
  end

  def get_play
    coordinates = [rand(10), rand(10)]

    until smart_play?(coordinates)
      coordinates = [rand(10), rand(10)]
    end

    @attack_history << coordinates
    coordinates
  end

  private

  def smart_play?(coordinates)
    @attack_history.include?(coordinates) ? false : true
  end
end
