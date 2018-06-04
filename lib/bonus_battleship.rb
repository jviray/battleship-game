require_relative 'bonus_board'
require_relative 'bonus_human_player'
require_relative 'bonus_computer_player'
require_relative 'bonus_ship'


class BattleshipGame
  attr_reader :player1, :player2

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @current_player = player1 # allows for two-board gameplay
  end

  def play_game
    p "Let's play Battleship!"
    puts

    setup

    until game_over?
      play_turn
      break if game_over?
      switch_players!
    end

    winner
  end

  def setup
    @player1.set_board
    @player2.set_board
  end

  def play_turn
    puts
    puts "It's #{@current_player.name}'s turn to attack."
    display_status
    pos = @current_player.get_play

    until valid?(pos)
      pos = @pcurent_player.get_play
    end

    attack(pos)
  end

  def display_status
    count = current_player_attack_board.count
    if count > 1
      puts "There are #{count} ships left."
    else
      puts "There is #{count} ship left."
    end
  end

  def valid?(pos)
    pos.is_a?(Array) && current_player_attack_board.inside?(pos) # note: #inside? (invokes #in_range)
  end

  def attack(pos)
    if current_player_attack_board[pos] == :s
      puts "Target hit!"
      current_player_attack_board[pos] = :x
    else
      puts "No hit."
      current_player_attack_board[pos] = :x
    end
  end

  def game_over?
    return true if @player2.board.won? # true if player1 destroyed all the ships
    return true if @player1.board.won? # true if player2 destroyed all the ships
    false
  end

  def current_player_attack_board
    @current_player == player1 ? @player2.board : @player1.board
  end

  def switch_players!
    @current_player = @current_player == player1 ? player2 : player1
  end

  def winner
    winner = @player2.board.won? ? @player1.name : @player2.name
    puts "#{winner} wins!"
  end
end
