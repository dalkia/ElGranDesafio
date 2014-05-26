package controller
{
	import flash.filters.DisplacementMapFilterMode;
	import model.Conflict;
	import model.News;
	import model.Solution;
	import model.Task;
	
	/**
	 * ...
	 * @author Juanola
	 */
	public class SimulationManager
	{
		
		private static var _instance:SimulationManager;
		
	
		private var _profileManager:ProfileManager;
		private var _taskManager:TaskManager;
		private var _conflictManager:ConflictManager;
		private var _newsManager:NewsManager;
		private var _timeManager:TimeManager;
		private var _mainView:Main;
		
		private var _totalMoney:Number;
		
		public function SimulationManager()
		{
			_profileManager = new ProfileManager();
			_taskManager = new TaskManager();
			_conflictManager = new ConflictManager();
			_newsManager = new NewsManager();
			_timeManager = new TimeManager(3);
			_totalMoney = 0;
		}
		
		public function startGame()
		{
			_mainView.addChild(ViewManager.getInstance().startScreen);
		}
		
		public function startSimulation()
		{
			_mainView.removeChild(ViewManager.getInstance().carousel);
			_mainView.addChild(ViewManager.getInstance().mainSimulationScreen);
			ViewManager.getInstance().mainSimulationScreen.addCharactersAnimations(_profileManager.getActiveAnimations());
			dayEnded(0);
			_timeManager.startTimers();
		}
		
		public function dayEnded(day:int):void
		{
			if (day == 10)
			{
				ViewManager.getInstance().mainSimulationScreen.setGameOver();
				_timeManager.endTimers();
			}
			else
			{
				var conflictsForDay : Array = _profileManager.getConflictsForDay(day);
				var currentNews : News = _newsManager.activeNews[day];
				ViewManager.getInstance().mainSimulationScreen.createNews(currentNews, day);
				_conflictManager.addActiveConflicts(conflictsForDay);
				ViewManager.getInstance().mainSimulationScreen.setDay(day + 1);
			}
		}
		
		
		
		
		
		public function startCharacterSelectionScreen()
		{
			_profileManager.createProfiles();
			_conflictManager.createConflicts();
			_newsManager.createNews();
		}
		
		public function set mainView(value:Main):void
		{
			_mainView = value;
		}
		
		public function get taskManager():TaskManager
		{
			return _taskManager;
		}
		
		public function get profileManager():ProfileManager
		{
			return _profileManager;
		}
		
		public function profilesLoadComplete():void
		{
			_mainView.removeChild(ViewManager.getInstance().startScreen);
			ViewManager.getInstance().carousel.showCards(_profileManager.profileCards);
			_mainView.addChild(ViewManager.getInstance().carousel);
		}
		
		public static function getInstance():SimulationManager
		{
			if (_instance == null)
			{
				_instance = new SimulationManager();
			}
			return _instance;
		}
		
		public function getCurrentLazyProfiles():Array
		{
			return _profileManager.getCurrentLazyProfiles();
		}
		
		public function startNewTask(task:Task, selectedProfiles:Array):void
		{
			for (var i:int = 0; i < selectedProfiles.length; i++)
			{
				selectedProfiles[i].lazy = false;
			}
			_taskManager.startTask(task, selectedProfiles);
			SimulationManager.getInstance().profileManager.addProgressBar(selectedProfiles, task.totalTime);
		}
		
		public function taskComplete(totalResult:Number, peopleSelected:Array):void
		{
			for (var i:int = 0; i < peopleSelected.length; i++)
			{
				peopleSelected[i].lazy = true;
			}
			_totalMoney += totalResult;
			ViewManager.getInstance().mainSimulationScreen.setTotalMoney(_totalMoney);
		}
		
		public function startSolution(solution:Solution, conflict:Conflict):void 
		{
			_conflictManager.removeActiveConflict(conflict);
			ViewManager.getInstance().mainSimulationScreen.computer.mailScreen.removeSolutions();
			ViewManager.getInstance().mainSimulationScreen.computer.mailScreen.goBackToInitialScreen();
		}
		
		public function getActiveConflicts():Array 
		{
			return _conflictManager.activeConflicts;
		}
	
	}

}

