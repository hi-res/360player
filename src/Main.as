package {
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;

	/**
	 * @author mikepro
	 */
	public class Main extends Sprite {

		private var m3d : MainView;		
   
		[SWF(width=640,height=480,backgroundColor=0x000000)]
		public function Main() {
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			addChild(m3d = new MainView());
		}		

	
	}
}
