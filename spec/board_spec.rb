require "spec_helper"

describe ToyRobot::Board do

	before :each do
		@board = ToyRobot::Board.new
	end

	describe "#new" do
	    it "simply create a new Board" do
	        @board.should be_an_instance_of ToyRobot::Board
	    end

	    it "creates a Board with 5 x 5 size" do
	        @board.width.should eql 4
	        @board.height.should eql 4
	    end
	end

	describe "#validate_placement" do
		it "should raise with an invalid placement" do
			lambda {@board.validate_placement(6,2)}.should raise_error
		end
	end

end