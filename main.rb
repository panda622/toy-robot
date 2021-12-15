require_relative 'lib/robot'

def get_input
  file = File.open("input.txt")
  file_data = file.readlines.map(&:chomp)

  robot = Robot::Action.new
  file_data.each do |action|
    robot.action(action.split[0], action.split[1].to_s.split(','))
  end
end

get_input
