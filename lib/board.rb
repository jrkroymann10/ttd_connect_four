# lib/board

class Board
  attr_reader :display, :circle
  def initialize
    @c = "\u25c9".encode('utf-8')
    @display = []

    for i in 0..12
      if i.odd?
        @display += [' | ' + @c + ' | ' + @c + ' | ' + @c + ' | ' + @c + ' | ' + @c + ' | ' + @c + ' | ' + @c + ' |']   
      else
        @display += [' -----------------------------']
      end
    end

    @display += ['_|_                         _|_']
  end
end

x = Board.new
puts ''
puts x.display
puts ''
