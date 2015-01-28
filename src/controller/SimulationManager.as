package controller
{
	import flash.filters.DisplacementMapFilterMode;
	import flash.utils.Dictionary;
	import model.Conflict;
	import model.Conversation.Conversation;
	import model.Gift;
	import model.News;
	import model.Penalty;
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
		private var _giftManager:GiftManager;
		private var _mainView:Main;
		
		private var _totalMoney:Number;
		private var _teamPoints:Number;
		
		private var _trainingTime : int;
		private var _trainingCost : int;
		private var _dayDuration : int;
		
		private var _partyCost : int;
		
		private var _currentDay : int;
		
		private var _budget : int;
		
		public function SimulationManager()
		{
			_trainingCost = 10;
			_partyCost = 20;
			_profileManager = new ProfileManager();
			_taskManager = new TaskManager();
			_conflictManager = new ConflictManager();
			_newsManager = new NewsManager();
			_giftManager = new GiftManager();
			_totalMoney = 0;
			_currentDay = 0;
			_teamPoints = 0;
			
		}
		
		public function startGame()
		{
			_mainView.addChild(ViewManager.getInstance().startScreen);
		}
		
		public function startSimulation()
		{
			_mainView.removeChild(ViewManager.getInstance().carousel);	
			_budget = parseInt(ViewManager.getInstance().startScreen.budget_txt.text);
			_mainView.addChild(ViewManager.getInstance().mainSimulationScreen);
			ViewManager.getInstance().mainSimulationScreen.addCharactersAnimations(_profileManager.getActiveAnimations());
			ViewManager.getInstance().mainSimulationScreen.setBudget(_budget);
			dayEnded(0);
			hourEndend(1);
			updateGroupAttributes(_profileManager.getGroupParameters());
			ViewManager.getInstance().mainSimulationScreen.updateTeamPoints(0);
			_dayDuration = parseInt(ViewManager.getInstance().startScreen.dayDuration_txt.text);
			_timeManager = new TimeManager(_dayDuration);
			_trainingTime = dayDuration*1000;
			_timeManager.startTimers();
		}
			
		
		public function dayEnded(day:int):void
		{
			if (day == 10)
			{
				//for each(var profile : Profile in _profileManager.activeProfiles) {
				//	_totalMoney = _totalMoney - profile.wage;
				//}
				_timeManager.endTimers();
		
			//	ViewManager.getInstance().mainSimulationScreen.setTotalMoney(_totalMoney);
				ViewManager.getInstance().mainSimulationScreen.setGameOver(_profileManager.activeProfiles, _budget, _teamPoints, taskManager.getCompleteTasks());
				
			}
			else
			{
				for (var i : int = 0; i < _conflictManager.activeConflicts.length; i++) {
					_conflictManager.applyPenalty(_conflictManager.activeConflicts[i]);
				}
				_currentDay = day;
				var conflictsForDay : Array = _profileManager.getConflictsForDay(day);
				var currentNews : News = _newsManager.activeNews[day];
				ViewManager.getInstance().mainSimulationScreen.createNews(currentNews, day);
				if (currentNews.affection != 0) {
					_profileManager.increaseMotivacion(_profileManager.activeProfiles, currentNews.affection);
					_profileManager.increaseProactividad(_profileManager.activeProfiles, currentNews.affection);
				}				
				_conflictManager.addActiveConflicts(conflictsForDay);
				ViewManager.getInstance().mainSimulationScreen.setDay(day + 1);
			}
		}
		
				
		public function startCharacterSelectionScreen()
		{			
			_profileManager.loadProfiles();
			_conflictManager.loadConflicts();
			_newsManager.loadNews();
			_giftManager.loadGifts();
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
		
		public function get dayDuration():int 
		{
			return _dayDuration;
		}
		
		public function get giftManager():GiftManager 
		{
			return _giftManager;
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
			_teamPoints += totalResult;
			ViewManager.getInstance().mainSimulationScreen.updateTeamPoints(_teamPoints);
			//ViewManager.getInstance().mainSimulationScreen.setTotalMoney(_totalMoney);
		}
		
		public function addPoorWorkConflicts(peopleSelected : Array):void{
			var poorEmails : Array = new Array();
			for each(var profileTA : Profile in peopleSelected) {
				var poorEmail : Conflict = new Conflict(0, "Este tarea fue dificil", "El equipo de trabajo que me asigno no me parecio bueno",new Penalty(0), null, profileTA,false);
				poorEmails.push(poorEmail);
			}
			_conflictManager.addActiveConflicts(poorEmails);

		}
		
		public function addGreatWorkConflicts(peopleSelected : Array):void{
			var niceEmails : Array = new Array();
			for each(var profileTA : Profile in peopleSelected) {
				var goodEmail : Conflict = new Conflict(0, "Este tarea fue excelente!", "Que buen equipo de trabajo",new Penalty(0), null, profileTA,false);
				niceEmails.push(goodEmail);
			}
			_conflictManager.addActiveConflicts(niceEmails);

		}
		
		public function removeConflict(conflict:Conflict):void 
		{
			_conflictManager.removeActiveConflict(conflict);	
			ViewManager.getInstance().mainSimulationScreen.computer.mailScreen.goBackToInitialScreen();			
		}
		
		public function startSolution(solution:Solution, conflict:Conflict):void 
		{
			_conflictManager.removeActiveConflict(conflict);		
			_profileManager.increaseEmpatia(new Array(conflict.owner), solution.affection);
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
			if (_budget >= _trainingCost) {
				_budget -= _trainingCost;
				ViewManager.getInstance().mainSimulationScreen.setBudget(_budget);
				return _profileManager.startTraining(profile,0.5);				
			}else {
				ViewManager.getInstance().mainSimulationScreen.errors_txt.text = "No se puede iniciar una capacitación";
				Utils.fadeInOut(ViewManager.getInstance().mainSimulationScreen.errors_txt, false);
				return false;				
			}
		
		}
		
		public function updateGroupAttributes(groupParameters : Array):void 
		{			
			ViewManager.getInstance().mainSimulationScreen.setGroupParamaters(groupParameters[0], groupParameters[1], groupParameters[2], groupParameters[3]);
		}
		
			
		public function hourEndend(hourDuration:int):void 
		{
			ViewManager.getInstance().mainSimulationScreen.addOneHour(hourDuration);
		}
		
		public function getActiveProfiles():Array 
		{
			return _profileManager.activeProfiles;
		}
		
		public function giveGift(gift:Gift, selectedProfiles:Array):void 
		{
			var results : Array = new Array;
			if (gift.giftType == "Individual") {
				if (_budget >= (gift.cost *  selectedProfiles.length)) {
					_budget -= gift.cost *  selectedProfiles.length;
					for each(var profile : Profile in selectedProfiles) {
						var result : int = _profileManager.giveGift(profile, gift);	
						var resultEmail : Conflict;
						if (result > 0) {
							resultEmail = new Conflict(0, "Gracias por el regalo!", "Estuvo espectacular, me encanto jefe. Maestro!"  + gift.name, new Penalty(0), null, profile,false);
							profile.gifts.push(gift.name + " " +  gift.cost + " Bueno");
						}else if (result == 0) {
							resultEmail = new Conflict(0, "Agradecimiento", "Le agradezco el regalo."  + gift.name,new Penalty(0), null, profile, false);
							profile.gifts.push(gift.name + " " +  gift.cost + " Medio");
						}else {
							resultEmail = new Conflict(0, "En serio?", "No me ha gustado su regalo"  + gift.name,new Penalty(0), null, profile, false);
							profile.gifts.push(gift.name + " " +  gift.cost + " Malo");
						}
						results.push(resultEmail);
					}
					ViewManager.getInstance().mainSimulationScreen.setBudget(_budget);
				}else {					
					ViewManager.getInstance().mainSimulationScreen.errors_txt.text = "No hay presupuesto suficiente";
					Utils.fadeInOut(ViewManager.getInstance().mainSimulationScreen.errors_txt, false);
				}
			}else {
				if (_budget >= (gift.cost)) {
					_budget -= gift.cost;
					for each(var profile : Profile in profileManager.activeProfiles) {
						var result : int = _profileManager.giveGift(profile, gift);		
						var resultEmail : Conflict;
						if (result > 0) {
							resultEmail = new Conflict(0, "Gracias por el regalo!", "Estuvo espectacular, me encanto jefe. Maestro!"  + gift.name, new Penalty(0), null, profile,false);
							profile.gifts.push(gift.name + " " +  gift.cost + " Bueno");
						}else if (result == 0) {
							resultEmail = new Conflict(0, "Agradecimiento", "Le agradezco el regalo."  + gift.name,new Penalty(0), null, profile, false);
							profile.gifts.push(gift.name + " " +  gift.cost + " Medio");
						}else {
							resultEmail = new Conflict(0, "En serio?", "No me ha gustado su regalo" + gift.name,new Penalty(0), null, profile, false);
							profile.gifts.push(gift.name + " " +  gift.cost + " Malo");
						}
						results.push(resultEmail);
					}
					ViewManager.getInstance().mainSimulationScreen.setBudget(_budget);
				}else {
					trace("Entre aca");
					ViewManager.getInstance().mainSimulationScreen.errors_txt.text = "No hay presupuesto suficiente";	
					Utils.fadeInOut(ViewManager.getInstance().mainSimulationScreen.errors_txt, false);
				}
			}
			_conflictManager.addActiveConflicts(results);		
		}
		
		
		
		
	
	}

}

