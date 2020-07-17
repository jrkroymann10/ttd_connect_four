class Player
  def initialize(input: $stdin, output: $stdout)
    @input = input
    @output = output
  end

  def ask_for_move
    @output.puts 'Input an integer between 1 and 7'
    loop do
      input = @input.gets.to_i
      return true if input >= 1 && input <= 7

      @output.puts 'Invalid. Try again:'
    end
  end
end
