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
      board.mark_spot(7, 'yellow')
      expect(board.display[11][21..25]).to eql('31;49')
      expect(board.display[11][213..217]).to eql('33;49')
    end

    it 'returns false if the column is filled to the top' do
      board = Board.new
      6.times { board.mark_spot(1, 'red') }
      expect(board.mark_spot(1, 'red')).to eql(false)
    end
  end

  describe '#win_check' do
    it 'returns true if a player has a vertical win condition' do
      board = Board.new
      4.times { board.mark_spot(1, 'red') }
      expect(board.win_check('red')).to eql(true)
    end

    it 'returns true if a player has a horizontal win condition' do
      board = Board.new
      board.mark_spot(1, 'red')
      board.mark_spot(2, 'red')
      board.mark_spot(3, 'red')
      board.mark_spot(4, 'red')
      expect(board.win_check('red')).to eql(true)
    end

    it 'returns true if a player has a diagonal win condition' do
      board = Board.new
      board.mark_spot(1, 'red')
      board.mark_spot(2, 'yellow')
      board.mark_spot(2, 'red')
      3.times { board.mark_spot(3, 'red') }
      board.mark_spot(4, 'yellow')
      3.times { board.mark_spot(4, 'red') }
      expect(board.win_check('red')).to eql(true)
    end

    it 'returns false if there is no win condition on the board' do
      board = Board.new
      3.times { board.mark_spot(1, 'red') }
      2.times { board.mark_spot(3, 'yellow') }
      expect(board.win_check('red')).to eql(false)
    end
  end
end
