package view 
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import controller.ViewManager;
	import model.Task;
	import view.ComputerScreens.AdminScreen;
	import view.ComputerScreens.ComputerScreen;
	import view.ComputerScreens.SelectionScreen;
	/**
	 * ...
	 * @author Juanola
	 */
	public class ComputerView extends MovieClip
	{
		private var _closeBigComputer : MovieClip;	
		private var _selectionScreen : SelectionScreen;
		private var _adminScreen : AdminScreen;
		
		private var currentScreen : ComputerScreen;
		
		public function ComputerView() 
		{
			super();	
			x = 23;
			y = 15;
			_closeBigComputer = new CloseBigComputer();
			_closeBigComputer.x = 696.75;
			_closeBigComputer.y = 24.3;
			_closeBigComputer.addEventListener(MouseEvent.CLICK, closeComputer);
			
			_selectionScreen = new SelectionScreen();
			_adminScreen = new AdminScreen();
			currentScreen = _selectionScreen;
			
		}
		
		public function showComputer():void {	
			addChild(currentScreen);
			addChild(_closeBigComputer);
		}
		
		public function openAdminScreen():void 
		{
			removeChild(currentScreen);			
			currentScreen = _adminScreen;
			_adminScreen.goBackToInitialScreen();
			addChildAt(currentScreen, 0);
		}
		
		public function openTaskView(task:Task):void 
		{
			_adminScreen.openTaskView(task);
		}
		
		private function closeComputer(e:MouseEvent):void 
		{			
			removeChild(_closeBigComputer);
			removeChild(currentScreen)
			currentScreen = _selectionScreen;
			ViewManager.getInstance().mainSimulationScreen.closeComputer();
		}
		
		public function get adminScreen():AdminScreen 
		{
			return _adminScreen;
		}
		
	}

}