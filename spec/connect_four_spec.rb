# spec/connect_four_spec
require './lib/board'

describe Board do
  it 'creates a 6x7 game display of uncolored circles' do
    board = Board.new
    expect(board.display.length).to eql(14)
  end
end
