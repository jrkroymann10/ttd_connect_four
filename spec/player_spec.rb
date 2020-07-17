require 'stringio'

RSpec.describe Player do
  context 'with input between 1 and 7' do
    it 'asks for input only once' do
      output = ask_for_move_with_input(5)
      expect(output).to eq "Input an integer between 1 and 7\n"
    end
  end

  context 'with input greater than 7' do
    it 'asks repeatedly until a number between 1 and 7 is provided' do
      output = ask_for_move_with_input(9, 8, 7)

      expect(output).to eq <<~OUTPUT
        Input an integer between 1 and 7
        Invalid. Try again:
        Invalid. Try again:
      OUTPUT
    end
  end

  context 'with input less than 1' do
    it 'asks repeatedly until a number between 1 and 7 is provided' do
      output = ask_for_move_with_input(0, -1, 3)

      expect(output).to eq  <<~OUTPUT
        Input an integer between 1 and 7
        Invalid. Try again:
        Invalid. Try again:
      OUTPUT
    end
  end

  def ask_for_move_with_input(*input_numbers)
    input = StringIO.new(input_numbers.join("\n") + "\n")
    output = StringIO.new

    player = Player.new(input: input, output: output)
    expect(player.ask_for_move).to be true

    output.string
  end
end
