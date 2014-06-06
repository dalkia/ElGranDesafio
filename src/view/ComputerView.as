package view 
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import controller.ViewManager;
	import model.Task;
	import view.ComputerScreens.AdminScreen;
	import view.ComputerScreens.ComputerScreen;
	import view.ComputerScreens.MailScreen;
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
		private var _mailScreen : MailScreen;
		
		private var currentScreen : ComputerScreen;
		
		public function ComputerView() 
		{
			super();	
			x = 23;
			y = 15;
			addChild(new ComputerBorder());
			_closeBigComputer = new CloseBigComputer();
			_closeBigComputer.x = 696.75;
			_closeBigComputer.y = 24.3;
			_closeBigComputer.addEventListener(MouseEvent.CLICK, closeComputer);
			
			_selectionScreen = new SelectionScreen();
			_adminScreen = new AdminScreen();
			_mailScreen = new MailScreen();
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
			addChild(currentScreen);
			addChild(_closeBigComputer);
		}
		
		
		
		public function openMailScreen():void 
		{
			removeChild(currentScreen);			
			currentScreen = _mailScreen;			
			addChild(currentScreen);
			addChild(_closeBigComputer);
			currentScreen.goBackToInitialScreen();
		}
		
		public function closeComputer(e:MouseEvent):void 
		{			
			currentScreen.closeScreen();
			removeChild(_closeBigComputer);			
			removeChild(currentScreen)
			currentScreen = _selectionScreen;
			ViewManager.getInstance().mainSimulationScreen.closeComputer();
		}
		
		public function get adminScreen():AdminScreen 
		{
			return _adminScreen;
		}
		
		public function get mailScreen():MailScreen 
		{
			return _mailScreen;
		}
		
	}

}