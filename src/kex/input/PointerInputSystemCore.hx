package kex.input;

class PointerInputSystemCore {
	var layers: Array<PointerInputLayer> = [];
	var captureLayer: PointerInputLayer = null; // TODO (DK) capture layer for every button?

	public function addTopLayer( layer: PointerInputLayer )
		layers.unshift(layer);

	public function removeLayer( layer: PointerInputLayer )
		layers.remove(layer);

	function processEvent( e: PointerEvent ) {
		if (captureLayer != null) {
			switch captureLayer(e) {
				case PointerProcessResult.Ignore:
					pumpThroughLayers(e);
				case PointerProcessResult.CaptureLayer(button):
					// TODO (DK) handle button
				case PointerProcessResult.ReleaseLayer(button):
					// TODO (DK) handle button
					captureLayer = null;
				case PointerProcessResult.SwallowEvent:
			}
		} else {
			pumpThroughLayers(e);
		}
	}

	function pumpThroughLayers( e: PointerEvent ) {
		var tmp = layers.copy();

		for (i in 0...tmp.length) {
			var layer = tmp[i];

			switch layer(e) {
				case PointerProcessResult.Ignore:
				case PointerProcessResult.CaptureLayer(button):
					// TODO (DK) handle button
					captureLayer = layer;
					return;
				case PointerProcessResult.ReleaseLayer(button):
					// TODO (DK) handle button
					// TODO (DK) assert as this is basically invalid without a capured layer?
					return;
				case PointerProcessResult.SwallowEvent:
					return;
			}
		}
	}
}
