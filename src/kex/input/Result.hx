package kex.input;

// TODO (DK) do these make sense?
// TODO (DK) or is the result actually a combination of these flags?
enum Result {
	Ignore;
	SwallowEvent;
	CaptureLayer;//( button: Int );
	ReleaseLayer;//( button: Int );
}
