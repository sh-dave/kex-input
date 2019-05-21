package kex.input;

enum abstract MouseEventType(#if debug String #else Int #end) {
    var Down;
    var Up;
    var Move;
    var Wheel;
    var Leave;
}
