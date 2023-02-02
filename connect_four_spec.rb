# frozen_string_literal: true

require_relative 'main'

describe GameBoard do


  describe '#make_board' do

    subject(:first_board) { described_class.new([]) }

    context 'when making a new gameboard' do
      it 'adds 6 arrays, each with a length of 7 to the @board instance variable' do
        expect { first_board.make_board }.to change {
          first_board.instance_variable_get(:@board).length }.from(0).to(6)
      end
    end
  end

  

end



# describe '#make_board' do
#   context 'when user number is between arguments' do
#     before do
#       valid_input = '3'
#       allow(game_input).to receive(:gets).and_return(valid_input)
#     end
#
#     it 'stops loop and does not display error message' do
#
#     end
#   end
#
