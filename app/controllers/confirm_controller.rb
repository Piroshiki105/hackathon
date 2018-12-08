class ConfirmController < ApplicationController

    @function = ""

    def confirm
        if params['blocks'] != nil && params['blocks'].length > 0  then

            maze = Maze.new params['stage']  
            @maze = maze.getMaze
            setBlockDisassembly params['blocks']
            @blockArray = getblockArray
            initFunction getblockArray
        else
            @blockArray = "未入力"
        end
    end

    def setBlockDisassembly blocks
        if !blocks.include?(",") then
            @blockArray = blocks.strip;
        else
            @blockArray = blocks.split(",")
        end
    end

    def getblockArray
        return @blockArray
    end

    def initFunction blockArray
        function = ""
        for block in blockArray do
            case block
            when "turnLeft"
                function += "turnLeft();"
            when "turnRight"
                function += "trunRight();"
            when "forward"
                function += "forward();"
            when "start_twice_for"
                function += "startTwiceFor();"
            when "end_twice_for"
                function += "endTwiceFor();"
            when "start_three_for"
                function += "startThreeFor();"
            when "end_three_for"
                function += "endThreeFor();"
            else

            end
            @function = function
        end
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
