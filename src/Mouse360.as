package  {
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	/**
	 * @author mikepro
	 */
	public class Mouse360 {
		private var _isMoving:Boolean;
		private var _click:Point = new Point();
		private var _displace:Point = new Point();
		private var _stage : Stage;
		
		public function Mouse360(stage:Stage){
			_stage = stage;
			_stage.addEventListener( MouseEvent.MOUSE_DOWN , handleMouseDown );			
		}
		
		private function handleMouseDown(event : MouseEvent) : void {
			_isMoving = true;
			_click.x = _stage.mouseY;
			_click.y = _stage.mouseX;
			_stage.addEventListener( MouseEvent.MOUSE_UP , handleMouseUp );
		}

		private function handleMouseUp(event : MouseEvent) : void {
			_isMoving = false;
			_stage.removeEventListener( MouseEvent.MOUSE_UP , handleMouseUp );
		}			
		
		public function update():void{
			if (_isMoving) {													
				_displace.x = (_click.x - _stage.mouseY) * .03;
				_displace.y = (_click.y - _stage.mouseX) * .03;				
			}
		}
		
		public function slow():void{
			_displace.x *= .8;
			_displace.y *= .8;
		}

		public function get displace() : Point {
			return _displace;
		}
	}
}
