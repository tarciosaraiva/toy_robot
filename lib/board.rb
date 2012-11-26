require "toy_robot/constants"

module ToyRobot

	class Board
		attr_reader :width, :height

		def initialize width = BOARD_WIDTH, height = BOARD_HEIGHT
			@width  = width
			@height = height
		end

		def is_valid_placement x, y
			unless (x >= 0 && x <= @width)
				return false
			end

			unless (y >= 0 && y <= @height)
				return false
			end

			return true
		end
	end

end