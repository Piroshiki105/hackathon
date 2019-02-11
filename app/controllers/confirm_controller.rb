require 'maze.rb'

class ConfirmController < ApplicationController

    @function = ""

    def confirm
        # 迷路
        maze = Maze.new params['stage']  
        @maze = maze.getMaze

        if params['blocks'] != nil && params['blocks'].length > 0  then
            setBlockDisassembly params['blocks']
            @blockArray = getblockArray
            @function = initFunction getblockArray
        else
            @blockArray = "未入力"
            @function = "window.addEventListener('load', alert('ブロックの読み込みに失敗しました。'));"
        end
    end

    #配列を返す
    def setBlockDisassembly blocks
        if !blocks.include?(",") then
            @blockArray = [blocks.strip];
        else
            @blockArray = blocks.split(",")
        end
    end

    def getblockArray
        return @blockArray
    end

    def initFunction blockArray
        function = "var functions = [function(){ console.log('start func');}];\n"
        for block in blockArray do
            case block
            when "turnLeft"
                function += "functions.push(turnLeft);\n"
            when "turnRight"
                function += "functions.push(turnRight);\n"
            when "forward"
                function += "functions.push(forward);\n"
            when "startFor"
                function += "for(var i = 0; i < 2; i++) {\n"
            when "endFor"
                function += "}\n"
            else

            end
        end
        function += "window.addEventListener('load', console.log(functions));\n";
        function += "var executeFunctions = function() {\n"
        function += "\tif(functions.length == 0) return;"
        function += "\t\tfunctions.shift(1)();\n"
        function += "\t\tsetTimeout(executeFunctions, 1000);\n"
        function += "};\n"
        function += "window.addEventListener('load', executeFunctions);\n"
        return function
    end

end