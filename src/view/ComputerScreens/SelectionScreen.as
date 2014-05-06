package view.ComputerScreens 
{
	import flash.events.MouseEvent;
	import controller.ViewManager;
	/**
	 * ...
	 * @author Juanola
	 */
	public class SelectionScreen extends ComputerScreen 
	{
		
		public function SelectionScreen() 
		{
			super();
			adminShortcut_mc.addEventListener(MouseEvent.CLICK, openAdminScreen);
		}
		
		private function openAdminScreen(e:MouseEvent):void 
		{
			ViewManager.getInstance().mainSimulationScreen.openAdminScreen();
		}
		
	}

}