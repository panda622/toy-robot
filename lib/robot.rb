module Robot
  class Action
    NORTH = 'NORTH'
    EAST = 'EAST'
    SOUTH = 'SOUTH'
    WEST = 'WEST'

    attr_accessor :size, :x_axis, :y_axis, :facing, :histories

    def initialize(x_axis = 0, y_axis = 0, facing = NORTH)
      @size = 5
      @x_axis = x_axis.to_i
      @y_axis = y_axis.to_i
      @facing = facing

      raise 'Invalid position!' unless valid_position?(@x_axis)
      raise 'Invalid position!' unless valid_position?(@y_axis)
      raise 'Invalid facing!' unless valid_facing?(facing)
    end

    def action(action, params)
      case action
        when 'PLACE'
          place(*params)
        when 'MOVE'
          move
        when 'LEFT'
          rotate('left')
        when 'RIGHT'
          rotate('right')
        when 'REPORT'
          puts report
        else
          raise "Invalid action for '#{action}'"
      end
    end

    def place(x_axis = 0, y_axis = 0, facing = NORTH)
      @facing = facing
      @x_axis = x_axis.to_i
      @y_axis = y_axis.to_i
    end

    def report
      "Output: #{x_axis},#{y_axis},#{facing}"
    end

    def move
      case @facing
        when NORTH
          new_position = @y_axis + 1
          @y_axis = new_position if valid_position?(new_position)
        when SOUTH
          new_position = @y_axis - 1
          @y_axis = new_position if valid_position?(new_position)
        when WEST
          new_position = @x_axis - 1
          @x_axis = new_position if valid_position?(new_position)
        when EAST
          new_position = @x_axis + 1
          @x_axis = new_position if valid_position?(new_position)
        end
    end

    def rotate(direction)
      case @facing
        when NORTH
          @facing = direction.upcase == 'LEFT' ? WEST : EAST
        when SOUTH
          @facing = direction.upcase == 'LEFT' ? EAST : WEST
        when WEST
          @facing = direction.upcase == 'LEFT' ? SOUTH : NORTH
        when EAST
          @facing = direction.upcase == 'LEFT' ? NORTH : EAST
        end
    end

    private

    def valid_position?(new_position)
      if new_position > 5 || new_position < 0
        puts 'Invalid position!'
        return false
      end

      true
    end

    def valid_facing?(facing)
      unless [NORTH, WEST, EAST, SOUTH].include?(facing)
        puts 'Invalid facing!'
        return false
      end

      true
    end
  end
end
