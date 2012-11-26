#!/usr/bin/env ruby
$LOAD_PATH.unshift File.expand_path('../../lib',__FILE__)
require 'controller'
require 'ruby-debug'

puts "##########################################################"
puts "#                  Welcome to Toy Robot                  #"
puts "##########################################################"
puts ""
puts "You control a robot that can move around a 5 x 5 board."
puts "He understands the following commands: PLACE, MOVE, LEFT, "
puts "RIGHT and REPORT. To start, you have to place the robot in"
puts "the board by issuing PLACE X,Y,[NORTH|SOUTH|EAST|WEST]"
puts ""

robot_controller = ToyRobot::Controller.new

while input = gets.chomp
	begin
		if (input.include? " ")
			command_and_args = input.split(" ")
			command = command_and_args.shift
			args = command_and_args[0].split(",")
		else
			command = input
		end

		if (command.casecmp("quit") == 0)
			puts "Bye :)"
			exit
		end

		output = robot_controller.execute_command(command.upcase, *args)

		if output.class.name.casecmp("string") == 0 && !output.empty?
			puts output
		end
	rescue ArgumentError => msg
		puts msg
	end
end
