"use strict";
const CANVAS_WIDTH = 600;
const CANVAS_HEIGHT = 400;

const BASE_X = 150;
const BASE_Y = 50;
const BLOCK_SPAN = 300 / maze.length;

window.onload = function() {
    let canvas = document.getElementById("canvas");
    canvas.width = CANVAS_WIDTH;
    canvas.height = CANVAS_HEIGHT;

    let ctx = canvas.getContext("2d");
    refreashScreen(ctx);
    drawMaze(ctx, BASE_X, BASE_Y, BLOCK_SPAN);
}

var execute = function() {
    alert(Processing.getInstanceById('app').getBlocksInfo());
}

var save = function() {
    alert("未実装");
}