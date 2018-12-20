"use strict";

var objPosX = 1;
var objPosY = 1;
var objDirection = 2;

const BASE_X = 300;
const BASE_Y = 50;
const BLOCK_SPAN = 600 / maze.length;

const CANVAS_WIDTH = 1200;
const CANVAS_HEIGHT = 800;

var image = new Image();

// テスト用　キー操作
window.addEventListener('keyup', function() {
    let ctx = document.getElementById("canvas").getContext("2d");
    switch(event.keyCode) {
        case 38: {
            goAhead(ctx);
            break;
        }
        case 39: {
            rotRight(ctx);
            break;
        }
        case 37: {
            rotLeft(ctx);
            break;
        }
    } 
});

window.addEventListener('load', function() {
    let canvas = document.getElementById("canvas");
    canvas.width = CANVAS_WIDTH;
    canvas.height = CANVAS_HEIGHT;

    let ctx = canvas.getContext("2d");

    image.onload = function() {
        ctx.globalAlpha = 1.0;
        ctx.globalCompositeOperation = "source-over";
        ctx.imageSmoothingEnabled = true;

        refreash(ctx);
    };

    image.src = "http://4.bp.blogspot.com/_Q5SpTKazer0/SaXGrslGszI/AAAAAAAAENM/EzdCD30IBhQ/s400/salmon+onigiri+3.jpg";
});

// 衝突判定
var isCollision = function(x, y) {
    return maze[y][x] < 0;
}

// ゴール判定
var isGoal = function(x, y) {
    return maze[y][x] == 2;
}

var forward = function() {
    console.log('fw start');
    var ctx = document.getElementById("canvas").getContext("2d");

    // 現在の向きによって、X方向・Y方向・-X方向・-Y方向
    let tmpX, tmpY;
    switch(objDirection) {
        case 0: {
            tmpX = objPosX;
            tmpY = objPosY - 1;
            break;
        }
        case 1: {
            tmpX = objPosX + 1;
            tmpY = objPosY;
            break;
        }
        case 2: {
            tmpX = objPosX;
            tmpY = objPosY + 1;
            break;
        }
        case 3: {
            tmpX = objPosX - 1;
            tmpY = objPosY;
            break;
        }
    }

    // 衝突判定
    if(isCollision(tmpX, tmpY)) {
        return;
    }

    // 問題ないので進ませる
    objPosX = tmpX; objPosY = tmpY;
    refreash(ctx);

    // ゴール判定
    if(isGoal(objPosX, objPosY)) {
        alert("GOAL!");
    }

    console.log('fw done');
}

// 右回転
var turnRight =  function() {
    console.log('tr start');

    var ctx = document.getElementById("canvas").getContext("2d");
    objDirection = (objDirection + 1) % 4;
    refreash(ctx);

    console.log('tr done');
}

// 左回転
var turnLeft = function() {
    console.log('tl start');

    var ctx = document.getElementById("canvas").getContext("2d");
    objDirection = (objDirection == 0) ? 3 : objDirection - 1;
    refreash(ctx);
    
    console.log('tl done');

}

// 画面の再描画
var refreash = function(ctx) {
    refreashScreen(ctx);
    drawMaze(ctx, BASE_X, BASE_Y, BLOCK_SPAN);

    // コンテキストの現在の状態を保持
    ctx.save();

    let x = BASE_X + (objPosX * BLOCK_SPAN) + (BLOCK_SPAN / 2);
    let y = BASE_Y + (objPosY * BLOCK_SPAN) + (BLOCK_SPAN / 2);

    ctx.translate(x, y);
    if(objDirection != 0)
        ctx.rotate(objDirection * 90 * Math.PI / 180);
    ctx.drawImage(image, -BLOCK_SPAN / 2, -BLOCK_SPAN / 2, BLOCK_SPAN, BLOCK_SPAN);

    // コンテキストの状態を復元
    ctx.restore();
}