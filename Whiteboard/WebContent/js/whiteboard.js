"use strict"

class Point {
	constructor(x, y) {
		this.x = x
		this.y = y
	}

	fromObject(obj) {
		this.x = obj.x
		this.y = obj.y
		return this
	}

	isEqual(other) {
		return other.x === this.x && other.y === this.y
	}

	toString() {
		return `[x=${this.x}, y=${this.y}]`
	}
}

const WBSocketMessage = {
	DrawAction: "WBSocketMessageDrawAction",
	ChatMessage: "WBSocketMessageChatMessage",
}

class Whiteboard {

	// MARK: - Basic constructor
	constructor(websocketURI, canvasSelector, refreshInterval) {
		// Set instance variables
		this._socket = new WebSocket(websocketURI)
		this._canvas = document.querySelector(canvasSelector)
		this._context = this._canvas.getContext("2d") // Drawing context

		// Internal rendering
		this._isPainting = false
		this._shouldRefreshRender = false
		this.clearPositions()
		this._refreshInterval = refreshInterval

		// Styles
		this._selectedColor = "#00DB92"
		this._selectedWidth = 5

		// Setup
		this.addNetworkHandlers()
		this.addUIEventListeners()
		this.startRunLoop()
		this.fitCanvas()
	}

	// MARK: - Initialization
	addNetworkHandlers() {
		let _this = this

		this._socket.addEventListener("open", function(e) {
			console.log("Opened whiteboard websocket")
		})

		this._socket.addEventListener("message", function(e) {
			let json = JSON.parse(e.data)

			// console.log("Got whiteboard message:", json)

			switch (json["type"]) {
			case WBSocketMessage.DrawAction:
				let action = json["data"]
				if (typeof action === "undefined" || action === null) return;
				_this.draw(
					(new Point()).fromObject(action.startPoint),
					(new Point()).fromObject(action.endPoint),
					action.color,
					action.width,
					false)
				break
			default:
				break
			}
		})

		this._socket.addEventListener("close", function(e) {
			console.log("Closed whiteboard websocket")
		})
	}

	addUIEventListeners() {
		let _this = this

		this._canvas.addEventListener("mousedown", function(e) {
			_this._isPainting = true
			_this.updatePosition(e)
		})

		this._canvas.addEventListener("mousemove", function(e) {
			if (_this._isPainting) _this.updatePosition(e);
 		})

		this._canvas.addEventListener("mouseup", function(e) {
			_this._isPainting = false
			_this.clearPositions()
		})

		window.addEventListener("resize", function() {
			_this.fitCanvas()
		})
	}

	// MARK: - Helpers
	updatePosition(event) {
		let mouseX = event.pageX - this.offsetLeft
		let mouseY = event.pageY - this.offsetTop
		let rect = this._canvas.getBoundingClientRect()

		let canvasX = event.pageX - rect.left
		let canvasY = event.pageY - rect.top

		let point = new Point(canvasX, canvasY)

		// console.log("Added new draw position:", point.toString(), this._drawPositions.length)

		if (this._lastDrawPosition.local !== null) {
			this.draw(this._lastDrawPosition.local, point, this._selectedColor, this._selectedWidth, true)
		}

		this._lastDrawPosition.local = point
		if (this._lastDrawPosition.remote === null) this._lastDrawPosition.remote = point
	}

	clearPositions() {
		this._lastDrawPosition = {
			local: null,
			remote: null,
		}
	}

	startRunLoop() {
		let _this = this
		if (this._runLoopInterval) clearInterval(this._runLoopInterval); // Cleanup
		this._runLoopInterval = setInterval(function() { _this.runLoop() }, this._refreshInterval)
	}

	runLoop() {
		// Guard
		if (!this._isPainting ||
			this._lastDrawPosition.remote === null ||
			this._lastDrawPosition.remote.isEqual(this._lastDrawPosition.local)) return;

		let startPoint = this._lastDrawPosition.remote
		let endPoint = this._lastDrawPosition.local
		this._lastDrawPosition.remote = this._lastDrawPosition.local

		this._socket.send(JSON.stringify({
			type: WBSocketMessage.DrawAction,
			data: {
				startPoint: startPoint,
				endPoint: endPoint,
				color: this._selectedColor, // "red", DEBUG
				width: this._selectedWidth,
			},
		}))
	}

	// MARK: - Drawing
	draw(startPoint, endPoint, color, width, isLocal) {
		this._context.strokeStyle = color
		this._context.lineJoin = "round"
		this._context.lineWidth = width

		this._context.beginPath()
		this._context.moveTo(startPoint.x, startPoint.y)
		this._context.lineTo(endPoint.x, endPoint.y)
		this._context.stroke()

		console.log("Drawing at:", isLocal, startPoint.toString(), endPoint.toString())
	}

	fitCanvas() {
		console.log("Resizing canvas...")

		// Resize canvas to fit
		this._canvas.width = window.innerWidth

		let headerHeight = document.querySelector("header").offsetHeight
		let tabHeight = document.querySelector(".tabs").offsetHeight
		this._canvas.height = window.innerHeight - (headerHeight+tabHeight) - 10
	}

}

new Whiteboard("ws://localhost:8080/Whiteboard/server/v1/whiteboard", "#whiteboard__canvas", 25)