# spec/connect_four_spec
require './lib/board'

describe Board do
  it 'creates a 6x7 game display of uncolored circles' do
    board = Board.new
    expect(board.display.length).to eql(14)
  end

  describe '#mark_spot' do
    it 'changes the color of the circle where the last move was made' do
      board = Board.new
      board.mark_spot(1, 'red')
      expect(board.display[11][21..25]).to eql('31;49')
    end

    it 'returns false if the column is filled to the top' do
      board = Board.new
      6.times { board.mark_spot(1, 'red') }
      expect(board.mark_spot(1, 'red')).to eql(false)
    end
  end
end
