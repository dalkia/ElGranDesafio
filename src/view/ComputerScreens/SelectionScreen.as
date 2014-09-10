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
			mailShortcut_mc.addEventListener(MouseEvent.CLICK, openMailScreen);
		}
		
		private function openMailScreen(e:MouseEvent):void 
		{
			ViewManager.getInstance().mainSimulationScreen.notification_mc.amount_txt.text = "0";
			ViewManager.getInstance().mainSimulationScreen.computer.openMailScreen();
		}
		
		private function openAdminScreen(e:MouseEvent):void 
		{
			ViewManager.getInstance().mainSimulationScreen.computer.openAdminScreen();
		}
		
	}

}