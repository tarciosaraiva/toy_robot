require "toy_robot/constants"

module ToyRobot

	class Robot
		attr_reader :x, :y, :is_placed, :facing_direction

		def move
			if (@is_placed)
				if @facing_direction == DIRECTIONS.index("NORTH")
					if (@y + 1) <= @y_limit then @y += 1 end
				elsif @facing_direction == DIRECTIONS.index("SOUTH")
					if (@y - 1) >= 0 then @y -= 1 end
				elsif @facing_direction == DIRECTIONS.index("EAST")
					if (@x + 1) <= @x_limit then @x += 1 end
				else
					if (@x - 1) >= 0 then @x -= 1 end
				end
			end
		end

		def place x, y, direction, board
			@is_placed = true
			@x = x
			@x_limit = board.width
			@y = y
			@y_limit = board.height
			@facing_direction = DIRECTIONS.index(direction)
		end

		def rotate direction
			if (@is_placed)
				if direction == COMMANDS[2]
					@facing_direction -= 1
					if (@facing_direction < 0) then @facing_direction = 3 end
				elsif direction == COMMANDS[3]
					@facing_direction += 1
					if (@facing_direction > 3) then @facing_direction = 0 end
				end
			end
		end

		def report
			if (@is_placed)
				return "I'm at #{@x},#{@y} facing #{DIRECTIONS[@facing_direction]}"
			else
				return "I can't function without a board"
			end
		end

		private
		attr_reader :x_limit, :y_limit
	end

end