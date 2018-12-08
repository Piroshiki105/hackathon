class ConfirmController < ApplicationController

    @function = ""

    def confirm
        if params['blocks'] != nil && params['blocks'].length > 0  then
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
