"use strict";

var maze = [
    [-1,-1,-1,-1,-1,-1],
    [-1, 1, 0, 0, 0,-1],
    [-1, 0,-1, 0, 0,-1],
    [-1, 0, 0,-1, 0,-1],
    [-1, 0, 0, 0, 2,-1],
    [-1,-1,-1,-1,-1,-1],
];

var objPosX = 1;
var objPosY = 1;
var objDirection = 2;

const BASE_X = 100;
const BASE_Y = 100;
const BLOCK_SPAN = 100;

const image = new Image();

var imgWidth;
var imgHeight;

var canvas;
var ctx;
window.onload = function() {
    canvas = document.getElementById("canvas");
    canvas.width = 1280;
    canvas.height = 720;

    ctx = canvas.getContext("2d");

    let widthHalf = parseInt(canvas.width / 2);
    let heightHalf = parseInt(canvas.height / 2);

    image.onload = function() {
        ctx.globalAlpha = 1.0;
        ctx.globalCompositeOperation = "source-over";
        ctx.imageSmoothingEnabled = true;

        imgWidth = image.width;
        imgHeight = image.height;

        refreash();
    };

    image.src = "img/test.jpeg";
};

// テスト用　キー操作
window.addEventListener('keyup', function() {
    switch(event.keyCode) {
        case 38: {
            goAhead();
            break;
        }
        case 39: {
            rotRight();
            break;
        }
        case 37: {
            rotLeft();
            break;
        }
    } 
});

// 衝突判定
var isCollision = function(x, y) {
    return maze[x][y] < 0;
}

// ゴール判定
var isGoal = function(x, y) {
    return maze[x][y] == 2;
}

var goAhead = function() {
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
    refreash();

    // ゴール判定
    if(isGoal(objPosX, objPosY)) {
        alert("GOAL!");
    }
}

// 右回転
var rotRight =  function() {
    objDirection = (objDirection + 1) % 4;
    refreash();
}

// 左回転
var rotLeft = function() {
    objDirection = (objDirection == 0) ? 3 : objDirection - 1;
    refreash();
}

// 画面の再描画
var refreash = function() {
    ctx.fillStyle = "rgb(0, 0, 128)";
    ctx.fillRect(0, 0, canvas.width, canvas.height);

    for(let i = 0; i < maze.length; i++) {
        for(let j = 0; j < maze.length; j++) {
            if(maze[i][j] == 0) {
                // 白色で進める場所を描画
                ctx.fillStyle = "rgb(255, 255, 255)";
            } else if(maze[i][j] == -1) {
                // 黒色で進めない場所を描画
                ctx.fillStyle = "rgb(0, 0, 0)";
            } else if(maze[i][j] == 1) {
                // 赤でスタート地点
                ctx.fillStyle = "rgb(128, 0, 0)";
            } else if(maze[i][j] == 2) {
                // 緑でゴール地点
                ctx.fillStyle = "rgb(0, 128, 0)";
            }
            let x = BASE_X + (i * BLOCK_SPAN);
            let y = BASE_Y + (j * BLOCK_SPAN);
            ctx.fillRect(x + 1, y + 1, BLOCK_SPAN - 2, BLOCK_SPAN - 2);
        }
    }

    // コンテキストの現在の状態を保持
    ctx.save();

    let x = BASE_X + (objPosX * BLOCK_SPAN) + (imgWidth / 2);
    let y = BASE_Y + (objPosY * BLOCK_SPAN) + (imgHeight / 2);

    ctx.translate(x, y);
    if(objDirection != 0)
        ctx.rotate(objDirection * 90 * Math.PI / 180);
    ctx.drawImage(image, -50, -50);

    // コンテキストの状態を復元
    ctx.restore();
}