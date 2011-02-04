package {
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.ui.Mouse;

	/**
	 * @author mikepro
	 */
	public class Mouse360 extends Sprite {
		private var _isMoving : Boolean;
		private var _click : Point = new Point();
		private var _displace : Point = new Point();
		private var _stage : Stage;
		private var arShape : Shape;
		private var endShape : Shape;
		private var startShape : Shape;

		public function Mouse360() {
			addEventListener(Event.ADDED_TO_STAGE, eAdded);

			addChild(startShape = new Shape());
			startShape.graphics.beginFill(0x999999);
			startShape.graphics.drawCircle(0, 0, 2);
			addChild(endShape = new Shape());
			addChild(arShape = new Shape());

			var l : int = -50; // ARROW LINE MAX LENGTH
			var w : int = -10; // ARROW LINE WIDTH

			// DRAW ARROW
			arShape.graphics.lineStyle(0, 0x999999);
			arShape.graphics.lineTo(0, -l);
			arShape.graphics.moveTo(0, 0);
			arShape.graphics.lineTo(w, - w);
			arShape.graphics.moveTo(0, 0);
			arShape.graphics.lineTo(-w, - w);
		}

		private function drawArrow() : void {
			endShape.x = _stage.mouseX;
			endShape.y = _stage.mouseY;
			arShape.x = mouseX;
			arShape.y = mouseY;
			var dx : Number = _click.x - mouseX;
			var dy : Number = _click.y - mouseY;
			var d : Number = Math.sqrt(dx * dx + dy * dy);

			arShape.rotation = - deg2rad(Math.atan2(_click.x - mouseX, _click.y - mouseY));
			arShape.scaleX = arShape.scaleY = Math.min(Math.max(d / 100, 0), .6);
		}

		private function eAdded(event : Event) : void {
			_stage = stage;
			stage.addEventListener(MouseEvent.MOUSE_DOWN, handleMouseDown);
		}

		private function deg2rad(val : Number) : Number {
			return val * 180 / Math.PI;
		}

		private function handleMouseDown(event : MouseEvent) : void {
			_isMoving = true;
			_click.x = _stage.mouseY;
			_click.y = _stage.mouseX;
			Mouse.hide();
			startShape.x = _click.x = _stage.mouseX;
			startShape.y = _click.y = _stage.mouseY;

			_stage.addEventListener(MouseEvent.MOUSE_UP, handleMouseUp);
			visible = true;
			drawArrow();
		}

		private function handleMouseUp(event : MouseEvent) : void {
			_isMoving = false;
			_stage.removeEventListener(MouseEvent.MOUSE_UP, handleMouseUp);
			visible = false;
			Mouse.show();
		}

		public function update() : void {
			slow();
			if (_isMoving) {
				_displace.x = (_click.y - _stage.mouseY) * -.03;
				_displace.y = (_click.x - _stage.mouseX) * -.03;
				drawArrow();
			}
		}

		private function slow() : void {
			_displace.x *= .8;
			_displace.y *= .8;
		}

		public function get rotate() : Point {
			return _displace;
		}
	}
}
