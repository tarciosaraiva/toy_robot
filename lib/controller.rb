require "toy_robot/constants"
require "robot"
require "board"

module ToyRobot

	class Controller
		attr_reader :board, :robot

		def initialize board = ToyRobot::Board.new, robot = ToyRobot::Robot.new
			@board = board
			@robot = robot
		end

		def execute_command cmd, *args
			if (cmd == nil || cmd == "") 
				raise ArgumentError.new("Please provide a command.")
			end

			if cmd == COMMANDS[0]

				unless args.size == 3
					raise ArgumentError.new("You must provide X, Y and one of [NORTH|SOUTH|EAST|WEST].")
				end

				x = args[0].to_i
				y = args[1].to_i

				if (@board.is_valid_placement x, y)
					@robot.place x, y, args[2], @board
				end
			elsif @robot.is_placed
				if cmd == COMMANDS[1]
					@robot.move
				elsif cmd == COMMANDS[2] || cmd == COMMANDS[3]
					@robot.rotate cmd
				elsif cmd == COMMANDS[4]
					return @robot.report
				else
					return "Sorry, I have no idea what you mean.\n\rValid commands are #{COMMANDS.join(', ')}."
				end
			else
				return "First command should be PLACE X,Y,[NORTH|SOUTH|EAST|WEST]."
			end				
		end
	end

end