package model 
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import controller.SimulationManager;
	/**
	 * ...
	 * @author Juanola
	 */
	public class Task 
	{
		private var _description : String;
		private var _title : String;		
		//private var _demands : Array;
		private var _timer : Timer;
	
		//private var _totalTime : Number;
		//private var _totalResult : int;
		
		private var _peopleSelected : Array;		
				
		private var _taskOutcome : TaskOutcome;
		
		public function Task(title : String, description : String, taskOutcome : TaskOutcome) 
		{
			_title = title;			
			_description = description;
			_taskOutcome = taskOutcome;
			
		}
		
		public function get title():String 
		{
			return _title;
		}
		
		public function get description():String 
		{
			return _description;
		}
		
	
		
		public function get peopleSelected():Array 
		{
			return _peopleSelected;
		}
		
	
		
		public function get taskOutcome():TaskOutcome 
		{
			return _taskOutcome;
		}
		
		public function set peopleSelected(value:Array):void 
		{
			_peopleSelected = value;
		}
		
		
	
		
		public function startTime():void {
			_timer = new Timer(_taskOutcome.outcome.time);			
			_timer.addEventListener(TimerEvent.TIMER, taskComplete);
			_timer.start();			
		}
		
		public function getOutcome():Object 
		{
			return _taskOutcome.getOutcome(_peopleSelected);
		}
		
		private function taskComplete(e:TimerEvent):void 
		{
			_timer.stop();
			_taskOutcome.activateOutcome();
			SimulationManager.getInstance().taskManager.taskComplete(this); 
		}
		
		/*
		public function getTime(profiles: Array):Number{
			var totalUsefulTime : Number = 0;
			var totalUselessTime : Number = 0;
			var totalUsefulPeople : Number = 0;
			var totalUselessPeople : Number = 0;
			var useful : Boolean = false;
			var useless : Boolean= false;
			for each (var profile: Profile in profiles){
				if(findInArray(profile.technicalProfile.type, _demands) != -1){
					totalUsefulTime += (1/profile.technicalProfile.getActualPerformance())*(1/profile.humanProfile.getActualPerformance());
					totalUsefulPeople++;
					useful = true;
				}else{
					totalUselessTime  += (1/profile.humanProfile.getActualPerformance());
					totalUselessPeople++;
					useless = true;
				}
			}
			if(useful && useless){
				return (1/totalUsefulPeople)*totalUsefulTime + (1/totalUselessPeople)*totalUselessTime;
			}else if(useful){
				return (1/totalUsefulPeople)*totalUsefulTime;
			}else{
				 return (1/totalUselessPeople)*totalUselessTime;			}

		}

		public function getResults(profiles : Array, totalTime : Number):Number{
			var totalUsefulAbilities : Number = 0;
			var totalUselessAbilities : Number = 0;
			var totalUselessEmotions : Number = 0;
			var totalUselessPeople : Number = 0;
			var useful : Boolean = false;
			var useless : Boolean = false;
			for  each(var profile : Profile in profiles) {				
				if(findInArray(profile.technicalProfile.type, _demands) != -1){
					totalUsefulAbilities += profile.technicalProfile.getActualPerformance();
					useful = true;
				}else{
					totalUselessAbilities  += profile.technicalProfile.getActualPerformance();
					totalUselessEmotions += profile.humanProfile.getActualPerformance();
					totalUselessPeople++;
					useless = true;
				}
			}
			if(useful && useless){
				return (1/totalTime)*(totalUsefulAbilities + (1/(3*totalUselessPeople))*(totalUselessAbilities + totalUselessEmotions));
			}else if(useful){
				return (1/totalTime)*totalUsefulAbilities;
			}else{
				return  (1/totalTime)*(1/(3*totalUselessPeople))*(totalUselessAbilities + totalUselessEmotions);
			}
		}
		
		
		//QUE LO CALCULE DE NUEVO???
		public function startTime(selectedProfiles : Array):void {
			_peopleSelected = selectedProfiles;
			_totalTime = getTime(selectedProfiles) * 100000;
			_totalResult = getResult(getResults(_peopleSelected, getTime(selectedProfiles)));
			_timer = new Timer(totalTime);			
			_timer.addEventListener(TimerEvent.TIMER, taskComplete);
			_timer.start();			
		}
		
		private function taskComplete(e:TimerEvent):void 
		{
			_timer.stop();
			SimulationManager.getInstance().taskManager.taskComplete(this); 
		}
		
		public function getResult(actualResult : Number):int {			
			if (actualResult < _maximumResult * 0.3) {
				SimulationManager.getInstance().profileManager.increaseNegativeAtributes(_peopleSelected);
				return _badResult;
			}else if (actualResult > _maximumResult * 0.31 && actualResult < _maximumResult * 0.79) {
				return _mediumResult;
			}else {
				SimulationManager.getInstance().profileManager.increasePositiveAtributes(_peopleSelected);
				return _bestResult;
			}
		}
		
		function findInArray(str:String, array : Array):int {
			for(var i:int = 0; i < array.length; i++){
				if(array[i] == str){				
					return i;
				}
			}
			return -1; //If not found
		}
		
		*/
		
	}

}