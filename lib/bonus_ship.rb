class Ship
  attr_reader :type, :length, :location

  def initialize (type, length)
    @type = type
    @length = length
    @location = []
  end

  def location=(coordinates)
    x, y = coordinates
      (y...y + @length).each do |i|
        @location << [x, i]
      end
  end

  def destroyed?(board, mark)
    @location.each {|coordinates| return false if board[coordinates] == mark}
    true
  end
end
