"use strict"

let CANVAS_SELECTOR = "#whiteboard__canvas"

let context = document.querySelector(CANVAS_SELECTOR).getContext("2d");

document.querySelector(CANVAS_SELECTOR).addEventListener("mousedown", function(e) {
    var mouseX = e.pageX - this.offsetLeft;
    var mouseY = e.pageY - this.offsetTop;

    let rect = this.getBoundingClientRect();

    paint = true;
    addClick(e.pageX - rect.left, e.pageY - rect.top);
    redraw();
});

document.querySelector(CANVAS_SELECTOR).addEventListener("mousemove", function(e) {
    if (paint) {
    	let rect = this.getBoundingClientRect();

        addClick(e.pageX - rect.left, e.pageY - rect.top, true);
        redraw();
    }
});

document.querySelector(CANVAS_SELECTOR).addEventListener("mouseup", function(e) {
    paint = false;
});

document.querySelector(CANVAS_SELECTOR).addEventListener("mouseleave", function(e) {
    paint = false;
});

var clickX = new Array();
var clickY = new Array();
var clickDrag = new Array();
var paint;

function addClick(x, y, dragging) {
    clickX.push(x);
    clickY.push(y);
    clickDrag.push(dragging);
}

function redraw() {
    context.clearRect(0, 0, context.canvas.width, context.canvas.height); // Clears the canvas

    context.strokeStyle = "#df4b26";
    context.lineJoin = "round";
    context.lineWidth = 5;

    for (var i = 0; i < clickX.length; i++) {
        context.beginPath();
        if (clickDrag[i] && i) {
            context.moveTo(clickX[i - 1], clickY[i - 1]);
        } else {
            context.moveTo(clickX[i] - 1, clickY[i]);
        }
        context.lineTo(clickX[i], clickY[i]);
        context.closePath();
        context.stroke();
    }
}