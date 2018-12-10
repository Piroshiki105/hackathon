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
                function += "sleep(1, turnLeft());\n"
            when "turnRight"
                function += "sleep(1, turnRight());\n"
            when "forward"
                function += "sleep(1, forward());\n"
            when "start_twice_for"
                function += "startTwiceFor();\n"
            when "end_twice_for"
                function += "endTwiceFor();\n"
            when "start_three_for"
                function += "startThreeFor();\n"
            when "end_three_for"
                function += "endThreeFor();\n"
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
            @maze = 'var maze = [[-1, -1, -1, -1, -1, -1], [-1, 1, 0, 0, 0, -1], [-1, 0, 0, 0, 0, -1], [-1, 0, -1, 0, 0, -1], [-1, 0, 0, 0, 2, -1], [-1, -1, -1, -1, -1, -1]];'
        when "55"
            @maze = 'var maze = [[-1, -1, -1, -1, -1, -1, -1], [-1, 1, 0, 0, 0, 0, -1], [-1, 0, 0, 0, 0, 0, -1], [-1, 0, 0, 0, 0, 0, -1], [-1, 0, 0, 0, 0, 0, -1], [-1, 0, 0, 0, 2, 0, -1], [-1, -1, -1, -1, -1, -1, -1]];'
        when "66"
            @maze = 'var maze = [[-1, -1, -1, -1, -1, -1, -1, -1], [-1, 1, 0, 0, 0, 0, 0, -1], [-1, 0, 0, 0, 0, 0, 0, -1], [-1, 0, 0, -1, -1, 0, 0, -1], [-1, 0, 0, 0, 0, 0, 0, -1], [-1, 0, 0, 0, 0, 0, 0, -1], [-1, 0, 0, 0, 2, 0, 0, -1], [-1, -1, -1, -1, -1, -1]];'
        else
        end
    end

    def getMaze
        return @maze
    end

end
