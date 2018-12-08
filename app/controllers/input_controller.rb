class InputController < ApplicationController
    def input
        maze = Maze.new params['stage']  
        @maze = maze.getMaze
    end
end

class Maze
    @maze

    def initialize stage
        case stage
        when "44"
            @maze = 'var maze = [[-1, -1, -1, -1, -1, -1], [-1, 1, 0, 0, 0, -1], [-1, 0, 0, 0, 0, -1], [-1, 0, 0, 0, 0, -1], [-1, 0, 0, 0, 2, -1], [-1, -1, -1, -1, -1, -1]];'
        when "55"
            @maze = 'var maze = [[-1, -1, -1, -1, -1, -1], [-1, 1, 0, 0, 0, -1], [-1, 0, 0, 0, 0, -1], [-1, 0, 0, 0, 0, -1], [-1, 0, 0, 0, 0, -1], [-1, 0, 0, 0, 2, -1], [-1, -1, -1, -1, -1, -1]];'
        when "66"
            @maze = 'var maze = [[-1, -1, -1, -1, -1, -1], [-1, 1, 0, 0, 0, -1], [-1, 0, 0, 0, 0, -1], [-1, 0, 0, 0, 0, -1], [-1, 0, 0, 0, 0, -1], [-1, 0, 0, 0, 0, -1], [-1, 0, 0, 0, 2, -1], [-1, -1, -1, -1, -1, -1]];'
        else
        end
    end

    def getMaze
        return @maze
    end

end
