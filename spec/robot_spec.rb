require "spec_helper"

describe ToyRobot::Robot do

	before :each do
		@board = ToyRobot::Board.new
		@robot = ToyRobot::Robot.new
	end

	describe "#new" do
	    before :each do
	        @robot.should be_an_instance_of ToyRobot::Robot
	    end

	    it "should not be in a board" do
	    	@robot.is_placed.should be_false
	    end

	    it "should report 'I can't function without a board'" do
	    	@robot.report.should eql "I can't function without a board"
	    end
	end

	describe "#place" do
		it "should be placed at 2,2 facing NORTH" do
			@robot.place 2, 2, ToyRobot::DIRECTIONS[0], @board

			@robot.x.should eql 2
			@robot.y.should eql 2
			@robot.facing_direction.should eql 0
			@robot.is_placed.should be_true
		end
	end

	describe "#move" do
		before :each do
			@robot.place 1, 1, ToyRobot::DIRECTIONS[0], @board
		end

		it "should move one step NORTH" do
			@robot.move

			@robot.x.should eql 1
			@robot.y.should eql 2
		end

		it "should move one step EAST" do
			@robot.rotate "RIGHT"
			@robot.move

			@robot.x.should eql 2
			@robot.y.should eql 1
		end

		it "should move one step SOUTH" do
			2.times {@robot.rotate "RIGHT"}
			@robot.move
			
			@robot.x.should eql 1
			@robot.y.should eql 0
		end

		it "should move one step WEST" do
			@robot.rotate "LEFT"
			@robot.move
			
			@robot.x.should eql 0
			@robot.y.should eql 1
		end
	end

	describe "#invalid move from SOUTH WEST corner" do
		before :each do
			@robot.place 0, 0, ToyRobot::DIRECTIONS[0], @board
		end

		it "should NOT move one step SOUTH" do
			2.times {@robot.rotate "RIGHT"}
			@robot.move
		end

		it "should NOT move one step WEST" do
			@robot.rotate "LEFT"
			@robot.move
		end

		after :each do
			@robot.x.should eql 0
			@robot.y.should eql 0
		end
	end

	describe "#invalid move from NORTH EAST corner" do
		before :each do
			@robot.place 4, 4, ToyRobot::DIRECTIONS[0], @board
		end

		it "should NOT move one step NORTH" do
			@robot.move
		end

		it "should NOT move one step EAST" do
			@robot.rotate "RIGHT"
			@robot.move
		end

		after :each do
			@robot.x.should eql 4
			@robot.y.should eql 4
		end
	end

	describe "#rotate" do
		before :each do
			@robot.place 2, 2, ToyRobot::DIRECTIONS[0], @board
		end

		it "should face EAST when rotating RIGHT" do
			@robot.rotate "RIGHT"
			@robot.facing_direction.should eql ToyRobot::DIRECTIONS.index("EAST")
		end

		it "should face WEST when rotating LEFT" do
			@robot.rotate "LEFT"
			@robot.facing_direction.should eql ToyRobot::DIRECTIONS.index("WEST")
		end

		it "should face SOUTH when rotating RIGHT twice" do
			2.times {@robot.rotate "RIGHT"}
			@robot.facing_direction.should eql ToyRobot::DIRECTIONS.index("SOUTH")
		end

		it "should face SOUTH when rotating LEFT twice" do
			2.times {@robot.rotate "LEFT"}
			@robot.facing_direction.should eql ToyRobot::DIRECTIONS.index("SOUTH")
		end

		it "should face NORTH when rotating RIGHT four times" do
			4.times {@robot.rotate "RIGHT"}
			@robot.facing_direction.should eql ToyRobot::DIRECTIONS.index("NORTH")
		end
	end

	describe "#report" do
		before :each do
			@robot.place 2, 2, ToyRobot::DIRECTIONS[0], @board
		end

		it "should report position 2,2 facing NORTH" do
			@robot.report.should eql "I'm at 2,2 facing NORTH"
		end

		it "should report position 2,3 facing NORTH" do
			@robot.move
			@robot.report.should eql "I'm at 2,3 facing NORTH"
		end

		it "should report position 2,2 facing EAST" do
			@robot.rotate "RIGHT"
			@robot.report.should eql "I'm at 2,2 facing EAST"
		end
	end

end