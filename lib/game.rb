require_relative 'board.rb'
require_relative 'player.rb'
require 'colorize'

class Game
  def initialize
    @board = Board.new
    @player1 = Player.new('player1', 'red')
    @player2 = Player.new('player2', 'yellow')
  end

  def new_game
    game_start
    until @board.win_check(@player1.color) || @board.win_check(@player2.color)
      move(@player1)
      break if @board.win_check(@player1.color)

      move(@player2)
    end
    end_message
  end

  private

  def game_start
    puts "\n" + '   welcome to connect four!   '.colorize(:black).colorize( :background => :white)
    puts "\n"
    puts @board.display
  end

  def move(player)
    temp = player.ask_for_move
    if @board.check_col_full(temp)
      while @board.check_col_full(temp)
        puts 'that column is already full, try again'
        temp = player.ask_for_move
      end
    end
    @board.mark_spot(temp, player.color)
    puts @board.display
  end

  def end_message
    if @board.win_check(@player1.color)
      puts "\n" + "       congrats #{@player1.name}!      ".colorize(:black).colorize( :background => :white)
    elsif @board.win_check(@player2.color)
      puts "\n" + "       congrats #{@player2.name}!      ".colorize(:black).colorize( :background => :white)
    end
  end
end
