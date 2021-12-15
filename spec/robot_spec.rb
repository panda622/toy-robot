require 'robot'
require 'spec_helpers'

RSpec.describe 'Robot::Action' do
  describe 'Functional Testing' do
    subject { Robot::Action.new }

    context '#move' do
      it 'facing NORTH should add y_axis by 1' do
        subject.facing = Robot::Action::NORTH
        subject.move
        subject.move
        expect(subject.y_axis).to eq 2
      end

      it 'facing EAST should add x_axis by 1' do
        subject.facing = Robot::Action::EAST
        subject.move
        expect(subject.x_axis).to eq 1
      end

      it 'facing WEST should subtract x_axis by 1' do
        subject.x_axis = 2
        subject.y_axis = 2
        subject.facing = Robot::Action::WEST
        subject.move
        expect(subject.x_axis).to eq 1
      end

      it 'facing SOUTH should subtract y_axis by 1' do
        subject.x_axis = 2
        subject.y_axis = 2
        subject.facing = Robot::Action::SOUTH
        subject.move
        expect(subject.y_axis).to eq 1
      end
    end

    context '#report' do
      it 'should contain Output keyword' do
        expect(subject.report).to include 'Output'
      end
    end

    context '#rotate' do
      it 'facing NORTH - turn left' do
        subject.facing = Robot::Action::NORTH
        subject.rotate('left')
        expect(subject.facing).to eq Robot::Action::WEST
      end

      it 'facing WEST - turn right' do
        subject.facing = Robot::Action::WEST
        subject.rotate('right')
        expect(subject.facing).to eq Robot::Action::NORTH
      end
    end

    context '#place' do
      it 'should force position to given values' do
        subject.x_axis = 2
        subject.y_axis = 2
        subject.facing = Robot::Action::WEST

        subject.place(1,1,Robot::Action::NORTH)
        expect(subject.x_axis).to eq 1
        expect(subject.y_axis).to eq 1
        expect(subject.facing).to eq Robot::Action::NORTH
      end
    end
  end

  describe 'Real case' do
    it '#a' do
      robot = Robot::Action.new(0,0,Robot::Action::NORTH)
      robot.move
      expect(robot.report).to eq('Output: 0,1,NORTH')
    end

    it '#b' do
      robot = Robot::Action.new(0,0,Robot::Action::NORTH)
      robot.rotate('left')
      expect(robot.report).to eq('Output: 0,0,WEST')
    end

    it '#c' do
      robot = Robot::Action.new(1,2,Robot::Action::EAST)
      robot.move
      robot.move
      robot.rotate('left')
      robot.move
      expect(robot.report).to eq('Output: 3,3,NORTH')
    end

    it '#d' do
      robot = Robot::Action.new(1,2,Robot::Action::EAST)
      robot.move
      robot.move
      robot.rotate('left')
      robot.move
      robot.place(1,2,Robot::Action::NORTH)
      expect(robot.report).to eq('Output: 1,2,NORTH')
    end

    it '#d' do
      robot = Robot::Action.new(1,2,Robot::Action::EAST)
      robot.move
      robot.rotate('left')
      robot.move
      robot.place(1,2,Robot::Action::NORTH)
      robot.move
      robot.rotate('right')
      expect(robot.report).to eq('Output: 1,3,EAST')
    end
  end
end
