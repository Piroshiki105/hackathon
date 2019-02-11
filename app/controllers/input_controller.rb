class InputController < ApplicationController
    def input
        maze = Maze.new params['stage']  
        @maze = maze.getMaze
    end
end