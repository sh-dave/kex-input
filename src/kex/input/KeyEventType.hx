package kex.input;

enum abstract KeyEventType(#if debug String #else Int #end) {
	var Down;
	var Up;
	var Press;
}
