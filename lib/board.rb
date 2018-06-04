class Board
  attr_reader :grid

  MARKS = {
    "ship"           => :s,
    "destroyed ship" => :x,
    "water"          => nil
  }

  def Board.default_grid
    Array.new(10) { Array.new(10) } # default 10x10 board
  end

  def Board.random
    Board.new(self.default_grid, true)
  end

  def initialize(grid = Board.default_grid, random = false)
    @grid = grid
    self.randomize if random
  end

  def [](coordinates)
    x, y = coordinates
    @grid[x][y]
  end

  def []=(coordinates, mark)
    x, y = coordinates
    @grid[x][y] = mark
  end

  def count
    ships = 0
    @grid.each do |row|
      row.each do |column|
        ships += 1 if column == :s
      end
    end
    ships

    # alternative: @grid.flatten.select {|space| space == :s}.length
  end

  def empty?(coordinates = nil)
    if coordinates
      self[coordinates].nil? # true if just water (nil) at coordinates
    else
      self.count == 0 ? true : false # no ships have been placed; empty board
    end
  end

  def randomize(num = 10)
    num.times { self.place_random_ship }
  end

  def place_random_ship
    raise Error, "BOARD FULL" if self.full?
    coordinates = [rand(self.grid.length), rand(self.grid.length)]
    until self.empty?(coordinates)
      coordinates = [rand(self.grid.length), rand(self.grid.length)]
    end

    # must first search for empty positin to place ship

    self[coordinates] = :s
  end

  def inside?(coordinates)
    x = coordinates[0]
    y = coordinates[1]
    true if x.between?(0, 10) && y.between?(0, 10)
  end

  def full?
    @grid.flatten.include?(nil) ? false : true
  end

  def won?
    @grid.flatten.include?(:s) ? false : true # note: flatten method for 2D arrays
  end

end
