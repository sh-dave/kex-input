package kex.input;

enum PointerEvent {
	Down( b: Int, x: Int, y : Int );
	Up( b: Int, x: Int, y: Int );
	Move( x: Int, y: Int, dx: Int, dy: Int );
	Wheel( delta: Int );
	Leave;
}
