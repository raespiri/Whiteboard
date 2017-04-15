"use strict"

class Message {
	constructor(message, sender) {
		this.message = message
		this.sender = sender
	}

	fromObject(obj) {
		this.message = obj.message
		this.sender = obj.sender
		return this
	}

	toObject() {
		return {
			message: this.message,
			sender: this.sender,
		}
	}

	toElement(templateElem) {
		let messageElem = document.createElement("div")
		messageElem.innerHTML = templateElem.innerHTML
		messageElem.classList = templateElem.classList
		messageElem.querySelector(".chat__message--sender").innerHTML = this.sender
		messageElem.querySelector(".chat__message--message").innerHTML = this.message
		return messageElem
	}

	// isEqual(other) {
	// 	return other.x === this.x && other.y === this.y
	// }
}

class Chat {

	// MARK: - Basic constructor
	constructor(websocketURI, username) {
		// Set instance variables
		this._socket = new WebSocket(websocketURI)
		this._username = username
		this._messageTemplate = document.querySelector("template.chat__message")
		this._chatInputElem = document.querySelector(".chat__message-input")
		this._chatScrollView = document.querySelector(".chat__scrollview")

		// Setup
		this.addNetworkHandlers()
		this.addUIEventListeners()
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
			case WBSocketMessage.ChatMessage:
				let data = json["data"]
				if (typeof data === "undefined" || data === null) return;
				_this.renderMessage((new Message()).fromObject(data))
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

		this._chatInputElem.addEventListener("keypress", function(e) {
			let currentMessage = this.value

			if (e.keyCode === 13) { // Return was pressed
				_this.sendMessage(new Message(currentMessage, _this._username))
			}
		})

		document.querySelector(".chat__message-send").addEventListener("click", function(e) {
			_this.sendMessage(new Message(_this._chatInputElem.value, _this._username))
		})

		document.querySelector(".chat__header").addEventListener("click", function(e) {
			let chat = this.parentElement

			if (chat.classList.contains("chat--collapsed")) {
				chat.classList.remove("chat--collapsed")
			} else {
				chat.classList.add("chat--collapsed")
			}
		})
	}

	// MARK: - Networking
	sendMessage(message) {
		console.log("Sending message:", message)

		this._socket.send(JSON.stringify({
			type: WBSocketMessage.ChatMessage,
			data: message,
		}))

		this.renderMessage(message)

		this._chatInputElem.value = ""
	}

	// MARK: - Rendering
	renderMessage(message) {
		let messageElem = message.toElement(this._messageTemplate)
		this._chatScrollView.appendChild(messageElem)

		this._chatScrollView.scrollTop = this._chatScrollView.scrollHeight
	}
}