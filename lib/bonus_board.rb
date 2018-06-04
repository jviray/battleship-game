class Board
  attr_reader :grid, :ships

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
    @ships = {
      :carrier => Ship.new("carrier", 5),
      :battleship => Ship.new("battleship", 4),
      :submarine => Ship.new("submarine", 3),
      :destroyer => Ship.new("destroyer", 3),
      :patrol => Ship.new( "patrol", 2)
    }
    random ? randomize(@ships) : parse(@ships)
  end

  def randomize(ships)
    ships.each { |type, ship| place_random_ship(ship) }
  end

  def parse(ships)
    p "Place all #{ships.length} ships on the board."
    i = ships.length
    ships.each do |type, ship|
      puts "Where would you like to place the '#{type.to_s.capitalize}' (Length: #{ship.length})?"
      place_ship(ship)
      puts "Only #{i -= 1} more ship(s) left to place."
      puts
    end
  end

  def place_random_ship(ship)
    raise Error, "BOARD FULL" if self.full?
    coordinates = [rand(self.grid.length), rand(self.grid.length)]
    until ship_fits?(coordinates, ship.length)
      coordinates = [rand(self.grid.length), rand(self.grid.length)]
    end

    extend_ship(coordinates, ship.length)
    ship.location = coordinates
  end

  def place_ship(ship)

    coordinates = get_coordinates
    until ship_fits?(coordinates, ship.length)
      puts "Can't place ship there, try again."
      puts
      coordinates = get_coordinates
    end

    extend_ship(coordinates, ship.length)
    ship.location = coordinates
    puts "Ship has been placed."
  end

  def get_coordinates
    print "Input starting coordinates: "
    coordinates = gets.chomp.split(", ").map do |coordinate|
      coordinate.to_i
    end

    coordinates
  end

  def extend_ship(coordinates, ship_length)
    x, y = coordinates
    (y...y + ship_length).each do |i|
      self[[x, i]] = :s
    end
  end

  def ship_fits?(starting_coordinates, ship_length)
    x, y = starting_coordinates
    (y...y + ship_length).each do |i|
      return false unless valid_pos?([x, i])
    end
    true
  end

  def valid_pos?(coordinates)
    if inside?(coordinates) && empty?(coordinates)
      return true
    else
      return false
    end
  end

  def [](coordinates)
    x, y = coordinates
    @grid[x][y]
  end

  def []=(coordinates, mark)
    x, y = coordinates
    @grid[x][y] = mark
  end

  def inside?(coordinates)
    x = coordinates[0]
    y = coordinates[1]
    return true if x.between?(0, @grid.length - 1) && y.between?(0, @grid.length - 1)
    false
  end

  def empty?(coordinates = nil)
    if coordinates
      return true if self[coordinates].nil?
      self[coordinates] == :s ? false : true
    else
      self.count == 0 ? true : false # no ships have been placed; empty board
    end
  end

  def count
    count = 5
    @ships.values.each { |ship| count -= 1 if ship.destroyed?(self, :s) }

    count
  end

  def full?
    @grid.flatten.include?(nil) ? false : true
  end

  def won?
    @grid.flatten.include?(:s) ? false : true # note: flatten method for 2D arrays
  end
end
