package kex.input;

@:structInit
class MouseEvent {
	public var type: MouseEventType;
	public var button: Int;
	public var x: Int;
	public var y: Int;
	public var dx: Int;
	public var dy: Int;
	public var lastX: Int;
	public var lastY: Int;
	public var wheelDelta: Int;
	public var window: Int;
}
