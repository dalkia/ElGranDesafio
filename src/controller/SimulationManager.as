﻿package controller
{
	import flash.filters.DisplacementMapFilterMode;
	import flash.utils.Dictionary;
	import model.Conflict;
	import model.Conversation.Conversation;
	import model.News;
	import model.Profile;
	import model.Solution;
	import model.Task;
	import view.ProfileState;
	
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
		
		private var _trainingTime : int;
		
		private var _currentDay : int;
		
		private var _conversation : Conversation;
		
		public function SimulationManager()
		{
			_profileManager = new ProfileManager();
			_taskManager = new TaskManager();
			_conflictManager = new ConflictManager();
			_newsManager = new NewsManager();
			_timeManager = new TimeManager(10);
			_conversation = new Conversation();
			_totalMoney = 0;
			_currentDay = 0;
			_trainingTime = 5000;
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
			updateGroupAttributes(_profileManager.getGroupParameters());
			_timeManager.startTimers();
		}
		
		public function dayEnded(day:int):void
		{
			if (day == 10)
			{
				for each(var profile : Profile in _profileManager.activeProfiles) {
					_totalMoney = _totalMoney - profile.wage;
				}
				ViewManager.getInstance().mainSimulationScreen.setTotalMoney(_totalMoney);
				ViewManager.getInstance().mainSimulationScreen.setGameOver();
				_timeManager.endTimers();
			}
			else
			{
				_currentDay = day;
				var conflictsForDay : Array = _profileManager.getConflictsForDay(day);
				var currentNews : News = _newsManager.activeNews[day];
				ViewManager.getInstance().mainSimulationScreen.createNews(currentNews, day);
				if (currentNews.affection != 0) {
					_profileManager.increasePositiveAtributes(_profileManager.activeProfiles, currentNews.affection);
				}
				
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
		
		public function get trainingTime():int 
		{
			return _trainingTime;
		}
		
		public function get conversation():Conversation 
		{
			return _conversation;
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
			var outcome : Object = _taskManager.startTask(task, selectedProfiles);
			SimulationManager.getInstance().profileManager.addTaskProgressBar(selectedProfiles, outcome.time);
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
		
		public function addPoorWorkConflicts(peopleSelected : Array):void{
			
		}
		
		public function startSolution(solution:Solution, conflict:Conflict):void 
		{
			_conflictManager.removeActiveConflict(conflict);		
			_profileManager.increasePositiveAtributes(new Array(conflict.owner), solution.affection);
			if (solution.nextConflict != 0) {
				
				var newConflict : Conflict;		
				var pendingConflictDictionary : Dictionary = _conflictManager.pendingConflicts ;
				var currentConflictArray : Array = pendingConflictDictionary[conflict.owner.name] as Array;
				for each(var nConflict : Conflict in currentConflictArray) {
					if (nConflict.id == solution.nextConflict) {
						newConflict = nConflict;
						currentConflictArray.splice(currentConflictArray.indexOf(nConflict), 1);
					}
				}
				//MENTIRIN
				if (2 + _currentDay < 10) {
					_profileManager.addConflict(conflict.owner, _currentDay + 2, newConflict);
				}
				
			}
			
			ViewManager.getInstance().mainSimulationScreen.computer.mailScreen.removeSolutions();
			ViewManager.getInstance().mainSimulationScreen.computer.mailScreen.goBackToInitialScreen();
		}
		
		public function affectHumanProfiles(affection : int, profilesSelected : Array):void{
			_profileManager.increasePositiveAtributes(profilesSelected,affection);
		}
		
		public function getActiveConflicts():Array 
		{
			return _conflictManager.activeConflicts;
		}
		
		public function startTraining(profile:Profile, newExperienice : Number):Boolean 
		{
			return _profileManager.startTraining(profile,0.5);
		}
		
		public function updateGroupAttributes(groupParameters : Array):void 
		{			
			ViewManager.getInstance().mainSimulationScreen.setGroupParamaters(groupParameters[0], groupParameters[1], groupParameters[2], groupParameters[3]);
		}
		
		public function makeParty():void 
		{
			_profileManager.increasePositiveAtributes(_profileManager.activeProfiles, 5);
			_totalMoney = _totalMoney - 20;
		}
		
		public function makeGlobalTraining():void 
		{
			for each(var profile : Profile in _profileManager.activeProfiles) {
				profile.animationManager.startTraining(1);
			}
			_totalMoney = _totalMoney - 30;
			
		}
	
	}

}

