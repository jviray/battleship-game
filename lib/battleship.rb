require_relative 'board'
require_relative 'human_player'
require_relative 'computer_player'

class BattleshipGame
  attr_reader :board, :player

  def initialize(player, board = Board.random)
    @player = player
    @board = board
  end

  def play_turn
    display_status
    pos = @player.get_play

    until valid?(pos)
      pos = @player.get_play
    end

    self.attack(pos)
  end

  def valid?(pos)
    pos.is_a?(Array) && @board.inside?(pos) # note: #inside? (invokes #in_range)
  end

  def attack(pos)
    if @board[pos] == :s
      puts "Target hit!"
      @board[pos] = :x
    else
      puts "No hit."
      @board[pos] = :x
    end
    puts
  end

  def count # counts number of ships left
    @board.count
  end

  def display_status
    if self.count > 1
      puts "There are #{self.count} ships left."
    else
      puts "There is #{self.count} ship left."
    end
  end

  def play_game
    p "Let's play Battleship!"
    puts
    self.play_turn until game_over?
    self.winner
  end

  def game_over?
    @board.won?
  end

  def winner
    puts "#{@player.name} wins!"
  end
end

if $PROGRAM_NAME == __FILE__
  print "Select Number of Players: One/Two? "
  input = gets.chomp

  # single-player:

  if input.downcase == "one" || input == "1"
    print "Human player (Y/N)? "
    input2 = gets.chomp
    if input2.downcase == "y" || input2.downcase == "yes"
      print "Input Name: "
      name = gets.chomp
      player = HumanPlayer.new(name)
    else
      player = ComputerPlayer.new("MacBookPro")
    end

    BattleshipGame.new(player).play_game

    # two-players:

elsif input.downcase == "two" || input == "2"
    require_relative 'bonus_battleship'
    print "Player 1: Human player (Y/N)? "
    input2 = gets.chomp
    if input2.downcase == "y" || input2.downcase == "yes"
      print "Input Name: "
      name = gets.chomp
      player1 = HumanPlayer.new(name)
    else
      player1 = ComputerPlayer.new("MacBookPro1")
    end

    print "Player 2: Human player (Y/N)? "
    input2 = gets.chomp
    if input2.downcase == "y" || input2.downcase == "yes"
      print "Input Name: "
      name = gets.chomp
      player2 = HumanPlayer.new(name)
    else
      player2 = ComputerPlayer.new("MacBookPro2")
    end

    BattleshipGame.new(player1, player2).play_game

  end
end
