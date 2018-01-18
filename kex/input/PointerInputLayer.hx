package kex.input;

interface PointerInputLayer {
	function processPointerEvent( event: PointerEvent ) : PointerProcessResult;
}
