class InputController < ApplicationController
    def input
        @stage = params['stage']
        maze = Maze.new params['stage']  
        @maze = maze.getMaze
    end
end

class Maze
    @stage
    @obstacle
    @startPosition
    @goalPosition
    @maze

    def initialize stage
        @stage = stage
        @startPosition
        @endPosition
    end

    def initialize stage
        case stage
        when 44
            @maze = [[-1, -1, -1, -1, -1, -1], [-1, 1, 0, 0, 0, -1], [-1, 0, 0, 0, 0, -1], [-1, 0, 0, 0, 0, -1], [-1, 0, 0, 0, 2, -1], [-1, -1, -1, -1, -1, -1]]
        when 55
            @maze = [[-1, -1, -1, -1, -1, -1], [-1, 1, 0, 0, 0, -1], [-1, 0, 0, 0, 0, -1], [-1, 0, 0, 0, 0, -1], [-1, 0, 0, 0, 0, -1], [-1, 0, 0, 0, 2, -1], [-1, -1, -1, -1, -1, -1]]
        when 66
            @maze = [[-1, -1, -1, -1, -1, -1], [-1, 1, 0, 0, 0, -1], [-1, 0, 0, 0, 0, -1], [-1, 0, 0, 0, 0, -1], [-1, 0, 0, 0, 0, -1], [-1, 0, 0, 0, 0, -1], [-1, 0, 0, 0, 2, -1], [-1, -1, -1, -1, -1, -1]]
        else
        end
    end

    def getMaze
        return @maze
    end

    def createObstacle
        rand(@n) + 1
    end

end
