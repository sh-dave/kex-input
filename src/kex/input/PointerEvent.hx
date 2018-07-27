package kex.input;

@:structInit class PointerEvent {
	public var type: PointerEventType;
	public var button: Int;
	public var x: Int;
	public var y: Int;
	public var dx: Int;
	public var dy: Int;
	public var wheelDelta: Int;
	public var window: Int;
}

// enum PointerEvent {
// 	Down( b: Int, x: Int, y : Int );
// 	Up( b: Int, x: Int, y: Int );
// 	Move( x: Int, y: Int, dx: Int, dy: Int );
// 	Wheel( delta: Int );
// 	Leave;
// }
