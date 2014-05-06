package controller 
{
	import flash.display.MovieClip;
	import view.StartScreen;
	/**
	 * ...
	 * @author Juanola
	 */
	public class Main extends MovieClip
	{
		
		private var _simulationManager : SimulationManager;
		private var _startScreen : StartScreen;
		
		public function Main() 
		{
			SimulationManager.getInstance().mainView = this;	
			SimulationManager.getInstance().startGame();
		}
		
	}

}