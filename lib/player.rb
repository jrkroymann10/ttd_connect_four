# lib/player

class Player
  attr_accessor :color, :name
  def initialize(name, color, input: $stdin, output: $stdout)
    @name = name
    @color = color
    @input = input
    @output = output
  end

  def ask_for_move
    input = 0
    @output.puts "input an integer between 1 and 7, #{@name}:"
    loop do
      input = @input.gets.to_i
      return input if input >= 1 && input <= 7

      @output.puts 'invalid. try again:'
    end
    input
  end
end
