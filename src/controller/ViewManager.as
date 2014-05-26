package controller 
{
	import view.Carousel;
	import view.MainSimulationScreen;
	import view.StartScreen;
	/**
	 * ...
	 * @author Juanola
	 */
	public class ViewManager 
	{
		
		private static var _instance : ViewManager;
		
		private var _startScreen : StartScreen;
		private var _carousel : Carousel;
		private var _mainSimulationScreen : MainSimulationScreen;
		
		
		public function ViewManager() 
		{
			_carousel = new Carousel();
			_mainSimulationScreen = new MainSimulationScreen();
			_startScreen = new StartScreen();			
		}
				
		public static function getInstance():ViewManager {
			if (_instance == null) {			
				_instance = new ViewManager();			
			}
			return _instance;
		}
				
		public function get startScreen():StartScreen 
		{
			return _startScreen;
		}
		
		public function get carousel():Carousel 
		{			
			return _carousel;
		}
		
		public function get mainSimulationScreen():MainSimulationScreen 
		{
			return _mainSimulationScreen;
		}
		
	}

}