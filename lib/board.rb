# lib/board
require 'colorize'

class Board

  @@ROWS = {
    1 => 6, 3 => 5, 5 => 4, 7 => 3, 9 => 2, 11 => 1
  }

  @@COLS = {
    21 => 1, 53 => 2, 85 => 3, 117 => 4, 149 => 5, 181 => 6, 213 => 7
  }

  attr_accessor :display, :moves

  def initialize
    @odd = ' | '.colorize(:blue)
    @even = ' -----------------------------'.colorize(:blue)
    @c = "\u25c9".encode('utf-8').colorize(:white)
    @moves = [[], [], [], [], [], []]
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

  def win_check(color)
    str_color = color_to_str(color)
    results = [false, false, false]

    @moves.each do |move|
      break if results.any? { |result| result == true }

      results[0] = horizontal_check(move, str_color)
      results[1] = vertical_check(str_color)
      results[2] = diagonal_check(str_color)
    end

    results.any? == true ? results[results.index(true)] : false
  end

  private

  # classes for win_check

  def horizontal_check(move, color)
    result = false
    count = 0
    if move.include?(color) && move.length >= 4
      move.each do |col|
        if count == 4
          result = true
          break
        elsif col == color
          count += 1
        elsif col != color
          count = 0
        end
      end
    end
    count == 4 ? true : result
  end

  def vertical_check(color)
    result = false
    count = 0
    for i in 0..6
      if count == 4
        result = true
        break
      end
      for j in 0..5
        if count == 4
          result = true
          break
        elsif @moves[j][i] == color
          count += 1
        elsif @moves[j][i] != color
          count = 0
        end
      end
    end
    result
  end

  def diagonal_check(color)
    result = false
    for i in 0..5
      break if result == true

      for j in 0..6
        break if result == true

        if @moves[i][j] == color && @moves[i + 1][j + 1] == color && @moves[i + 2][j + 2] == color && @moves[i + 3][j + 3] == color
          result = true
        elsif @moves[i][j] == color && @moves[i - 1][j - 1] == color && @moves[i - 2][j - 2] == color && @moves[i - 3][j - 3] == color
          result = true
        elsif @moves[i][j] == color && @moves[i - 1][j + 1] == color && @moves[i - 2][j + 2] == color && @moves[i - 3][j + 3] == color
          result = true
        elsif @moves[i][j] == color && @moves[i + 1][j - 1] == color && @moves[i + 2][j - 2] == color && @moves[i + 3][j - 3] == color
          result = true
        end
      end
    end
    result
  end

  # classes for mark_spot

  def find_column(column)
    (column + 20) + ((column - 1) * 31)
  end

  # finds lowest row in selected column that isn't already filled
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
    @moves[@@ROWS[row] - 1][@@COLS[temp] - 1] = color
  end
end

# x = Board.new
# puts x.display
# 1.times { x.mark_spot(1, 'yellow') }
# 2.times { x.mark_spot(2, 'yellow') }
# 2.times { x.mark_spot(3, 'red') }
# x.mark_spot(3, 'yellow')
# 2.times { x.mark_spot(4, 'red') }
# 2.times { x.mark_spot(4, 'yellow') }
# puts ''
# puts x.display
# p x.win_check('yellow')
