require "spec_helper"

describe ToyRobot::Controller do

	before :each do
		@robot = double("robot")
		@board = double("board")

		@controller = ToyRobot::Controller.new @board, @robot
	end

	it "should be an instance of Controller" do
		@controller.should be_an_instance_of ToyRobot::Controller
	end

	it "should have one Robot and one Board objects" do
		@controller.board.should_not be_nil
		@controller.robot.should_not be_nil
	end

	describe "#execute_command" do

		it "should throw exception with empty command" do
			lambda { @controller.execute_command }.should raise_exception
		end

		it "should return error message with invalid command" do
			@robot.stub(:is_placed).and_return(true)

			output = @controller.execute_command "BLA"
			output.should eql "Sorry, I have no idea what you mean.\n\rValid commands are PLACE, MOVE, LEFT, RIGHT, REPORT."
		end

		it "should return error message when first command is not PLACE" do
			@robot.stub(:is_placed).and_return(false)

			output = @controller.execute_command "MOVE"
			output.should eql "First command should be PLACE X,Y,[NORTH|SOUTH|EAST|WEST]."
		end

		it "should throw exception with PLACE command and no args" do
		end

		describe "after placement" do

			before :each do
				@robot.stub(:rotate)
				@robot.stub(:place)
				@robot.stub(:move)
				@robot.stub(:is_placed).and_return(true)

				@board.stub(:is_valid_placement).and_return(true)

				@controller.execute_command "PLACE",0,0,"NORTH"
			end

			it "should execute MOVE command" do
				@robot.should_receive(:move)
				@controller.execute_command "MOVE"
			end

			it "should execute LEFT command" do
				@robot.should_receive(:rotate).with("LEFT")
				@controller.execute_command "LEFT"
			end

			it "should execute RIGHT command" do
				@robot.should_receive(:rotate).with("RIGHT")
				@controller.execute_command "RIGHT"
			end

			it "should execute REPORT command" do
				@robot.stub(:report).and_return("report")
				output = @controller.execute_command "REPORT"
				output.should eql "report"
			end
		end

	end
end