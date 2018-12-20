"use strict";

// 画面の再描画
var refreashScreen = function(ctx) {
    ctx.fillStyle = "rgb(0, 0, 128)";
    ctx.fillRect(0, 0, canvas.width, canvas.height);
}

var drawMaze = function(ctx, baseX, baseY, blockSpan) {
    for(let x = 0; x < maze.length; x++) {
        for(let y = 0; y < maze.length; y++) {
            if(maze[y][x] == 0) {
                // 白色で進める場所を描画
                ctx.fillStyle = "rgb(255, 255, 255)";
            } else if(maze[y][x] == -1) {
                // 黒色で進めない場所を描画
                ctx.fillStyle = "rgb(0, 0, 0)";
            } else if(maze[y][x] == 1) {
                // 赤でスタート地点
                ctx.fillStyle = "rgb(128, 0, 0)";
            } else if(maze[y][x] == 2) {
                // 緑でゴール地点
                ctx.fillStyle = "rgb(0, 128, 0)";
            }
            ctx.fillRect(baseX + (x * blockSpan) + 1, baseY + (y * blockSpan) + 1, blockSpan - 2, blockSpan - 2);
        }
    }
}