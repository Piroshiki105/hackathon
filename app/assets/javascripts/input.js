var CANVAS_WIDTH = 600;
var CANVAS_HEIGHT = 400;

var BASE_X = 150;
var BASE_Y = 50;
var BLOCK_SPAN = 300 / maze.length;

window.onload = function() {
    var canvas = document.getElementById("canvas");
    canvas.width = CANVAS_WIDTH;
    canvas.height = CANVAS_HEIGHT;

    var ctx = canvas.getContext("2d");
    refreashScreen(ctx);
    drawMaze(ctx, BASE_X, BASE_Y, BLOCK_SPAN);
}

var execute = function() {
    var str = Processing.getInstanceById('app').getBlocksInfo();
    if(!str || str.length == 0) {
        alert("ブロックが何も置かれていません");
    } else {
        var size = parseInt(maze.length) - 2;
        location.href = "confirm.html?blocks=" + str + "&stage=" + size + "" + size ;
    }
}

var save = function() {
    alert("未実装");
}