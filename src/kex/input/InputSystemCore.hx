package kex.input;

class InputSystemCore {
	var layers: Array<InputLayer> = [];
	var captureLayer: InputLayer = null;

	public function addTopLayer( layer: InputLayer )
		layers.unshift(layer);

	public function removeLayer( layer: InputLayer )
		layers.remove(layer);

	function processMouseEvent( e: MouseEvent ) {
		if (captureLayer != null && captureLayer.mouse != null) {
			switch captureLayer.mouse(e) {
				case Ignore:
					pumpMouseEvent(e);
				case CaptureLayer:
				case ReleaseLayer:
					captureLayer = null;
				case SwallowEvent:
			}
		} else {
			pumpMouseEvent(e);
		}
	}

	function pumpMouseEvent( e: MouseEvent ) {
		var tmp = layers.copy();

		for (i in 0...tmp.length) {
			var layer = tmp[i];

			if (layer.mouse != null) {
				switch layer.mouse(e) {
					case Ignore:
					case CaptureLayer:
						captureLayer = layer;
						return;
					case ReleaseLayer:
						// TODO (DK) assert as this is basically invalid without a capured layer?
						return;
					case SwallowEvent:
						return;
				}
			}
		}
	}

	function processKeyEvent( e: KeyEvent ) {
		if (captureLayer != null && captureLayer.keys != null) {
			switch captureLayer.keys(e) {
				case Ignore:
					pumpKeyEvent(e);
				case CaptureLayer, ReleaseLayer:
					captureLayer = null;
				case SwallowEvent:
			}
		} else {
			pumpKeyEvent(e);
		}
	}

	function pumpKeyEvent( e: KeyEvent ) {
		var tmp = layers.copy();

		for (i in 0...tmp.length) {
			var layer = tmp[i];

			if (layer.keys != null) {
				switch layer.keys(e) {
					case Ignore:
					case CaptureLayer:
						captureLayer = layer;
						return;
					case ReleaseLayer:
						// TODO (DK) assert as this is basically invalid without a capured layer?
						return;
					case SwallowEvent:
						return;
				}
			}
		}
	}
}
