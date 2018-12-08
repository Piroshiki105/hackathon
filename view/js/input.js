"use strict";
const CANVAS_WIDTH = 1280;
const CANVAS_HEIGHT = 720;

const BASE_X = 50;
const BASE_Y = 50;
const BLOCK_SPAN = 600 / maze.length;

window.onload = function() {
    let canvas = document.getElementById("canvas");
    canvas.width = CANVAS_WIDTH;
    canvas.height = CANVAS_HEIGHT;

    let ctx = canvas.getContext("2d");
    refreashScreen(ctx);
    drawMaze(ctx, BASE_X, BASE_Y, BLOCK_SPAN);
}