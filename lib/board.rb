# lib/board
require 'colorize'

class Board
  @red = "\e[0;31;49mi\e[0m"
  @yellow = "\e[0;33;49mi\e[0m"

  attr_accessor :display

  def initialize
    @odd = ' | '.colorize(:blue)
    @even = ' -----------------------------'.colorize(:blue)
    @c = "\u25c9".encode('utf-8').colorize(:white)
    @display = []

    for i in 0..12
      if i.odd?
        @display += [@odd + @c + @odd + @c + @odd + @c + @odd + @c + @odd + @c + @odd + @c + @odd + @c + @odd]
      else
        @display += [@even]
      end
    end

    @display += ['_|_                         _|_'.colorize(:blue)]
  end

  def mark_spot(column, color)
    temp = find_column(column)
    row = find_row(temp)
    new_col = color_to_str(color)
    row != 0 ? change_circle_color(temp, row, new_col) : false
  end

  private

  # classes for mark_spot
  def find_column(column)
    (column + 20) + ((column - 1) * 31)
  end

  def find_row(temp)
    array_row = 0
    rows = [1, 3, 5, 7, 9, 11]
    rows.each do |row|
      unless @display[row][temp..(temp + 4)] != '37;49'
        array_row = row
      end
    end
    array_row
  end

  def color_to_str(color)
    color == 'red' ? '31;49' : '33;49'
  end

  def change_circle_color(temp, row, color)
    @display[row].slice!(temp, 5)
    @display[row].insert(temp, color)
  end
end

x = Board.new
puts x.display
x.mark_spot(1, 'red')
puts ''
puts x.display
x.mark_spot(1, 'red')
puts ''
puts x.display
x.mark_spot(1, 'red')
puts ''
puts x.display
x.mark_spot(1, 'red')
puts ''
puts x.display
x.mark_spot(1, 'red')
puts ''
puts x.display
x.mark_spot(1, 'red')
puts ''
puts x.display 
puts ''

# x = "\e[0;34;49m | \e[0m\e[0;37;49m◉\e[0m"
# p x
# x.slice!(21, 5)
# p x[21]
# p x
# x.insert(21, '31;49')
# puts ''
# p x[21..25]
# p x

