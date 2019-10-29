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

	var _tmpmouse = [];

	function pumpMouseEvent( e: MouseEvent ) {
		// var tmp = layers.copy();
		final l = layers.length;

		for (i in 0...l) {
			_tmpmouse[i] = layers[i];
		}

		for (i in 0...l) {
			var layer = _tmpmouse[i];

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

	final _tmpkeys = [];

	function pumpKeyEvent( e: KeyEvent ) {
		final l = layers.length;

		for (i in 0...l) {
			_tmpkeys[i] = layers[i];
		}

		for (i in 0...l) {
			var layer = _tmpkeys[i];

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
