package kex.input;

import haxe.ds.Option;
import kha.input.Keyboard;
import kha.input.Mouse;

typedef InputSystemOpts = {
	?noMouse: Bool,
	// ?noSurface: Bool,
	?windows: Array<Int>,
}

class InputSystem extends InputSystemCore {
	var me: MouseEvent = {
		x: 0, y: 0, dx: 0, dy: 0,
		button: 0, wheelDelta: 0,
		type: Leave,
		window: 0,
	}

	var ke: KeyEvent = {
		type: Up,
		code: Unknown,
		char: '',
	}

	public function new( ?opts: InputSystemOpts ) {
		if (opts == null || !opts.noMouse) {
			initMouse(opts == null ? [0] : opts.windows != null ? opts.windows : [0]);
		}

		initKeyboard();
	}

	function initKeyboard() {
		var keys = Keyboard.get();

		if (keys != null) {
			keys.notify(keyDownHandler, keyUpHandler, keyPressHandler);
		}
	}

	function initMouse( windows: Array<Int> ) {
		var mouse = Mouse.get(0);

		if (mouse != null) {
			for (id in windows) {
				mouse.notifyWindowed(id,
					mouseDownHandler.bind(_, _, _, id),
					mouseUpHandler.bind(_, _, _, id),
					mouseMoveHandler.bind(_, _, _, _, id),
					mouseWheelHandler.bind(_, id),
					mouseLeaveHandler.bind(id)
				);
			}
		}
	}

	function mouseDownHandler( b: Int, x: Int, y: Int, window: Int ) {
		me.type = Down;
		me.button = b;
		me.x = x;
		me.y = y;
		me.window = window;
		processMouseEvent(me);
	}

	function mouseUpHandler( b: Int, x: Int, y: Int, window: Int ) {
		me.type = Up;
		me.button = b;
		me.x = x;
		me.y = y;
		me.window = window;
		processMouseEvent(me);
	}

	function mouseMoveHandler( x: Int, y: Int, dx: Int, dy: Int, window: Int ) {
		me.type = Move;
		me.x = x;
		me.y = y;
		me.dx = dx;
		me.dy = dy;
		me.window = window;
		processMouseEvent(me);
	}

	function mouseWheelHandler( delta: Int, window: Int ) {
		me.type = Wheel;
		me.wheelDelta = delta;
		me.window = window;
		processMouseEvent(me);
	}

	function mouseLeaveHandler( window: Int ) {
		me.type = Leave;
		me.window = window;
		processMouseEvent(me);
	}

	function keyDownHandler( code ) {
		ke.type = Down;
		ke.code = code;
		processKeyEvent(ke);
	}

	function keyUpHandler( code ) {
		ke.type = Up;
		ke.code = code;
		processKeyEvent(ke);
	}

	function keyPressHandler( char ) {
		ke.type = Press;
		ke.char = char;
		processKeyEvent(ke);
	}
}
