package view 
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import controller.SimulationManager;
	
	/**
	 * ...
	 * @author Juanola
	 */
	public class StartScreen extends MovieClip 
	{
			
		public function StartScreen() 
		{
			super();
			startGame_mc.addEventListener(MouseEvent.CLICK, startGame);
		}
		
		private function startGame(e:MouseEvent):void 
		{
			SimulationManager.getInstance().startCharacterSelectionScreen();
		}
		
	}

}