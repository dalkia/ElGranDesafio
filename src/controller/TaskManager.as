package controller 
{
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Timer;
	import model.Task;
	import model.TaskOutcome;
	/**
	 * ...
	 * @author Juanola
	 */
	public class TaskManager 
	{
		
		private var _tasks : Array;
		private var _finishedTasks : Array;
		private var _currentTasks : Array;
		
		
		private var _maximumResult : Number;
		
		public function TaskManager() 
		{
			_tasks = new Array();
			_finishedTasks = new Array();
			_currentTasks = new Array();
		//	var minimumTime : Number  = (1 / (4 * 0.5 + 4 * 0.3 + 4 * 0.2 + 4 * 0.1))*(1/(4 * 0.5 + 4 * 0.3 + 4 * 0.2 + 4 * 0.1));
		//	_maximumResult  = (1 / minimumTime) * (4*0.5 + 4 * 0.3 + 4 * 0.2 + 4 * 0.1);
			createTasks();
		}
		
		public function startTask(task:Task, selectedProfiles : Array):Object 
		{
			_tasks.splice(_tasks.indexOf(task), 1);
			_currentTasks.push(task);	
			task.peopleSelected = selectedProfiles;
			var outcome : Object = task.getOutcome();
			task.startTime();	
			return outcome;					
		}		
		
		public function taskComplete(task:Task):void 
		{
			_currentTasks.splice(_currentTasks.indexOf(task), 1);
			_finishedTasks.push(task);
			SimulationManager.getInstance().taskComplete(task.taskOutcome.outcome.result, task.peopleSelected);
		}		
		
		private function createTasks() {			
			var taskXMLLoader:URLLoader = new URLLoader();			
			taskXMLLoader.load(new URLRequest("../resources/xml/Tasks.xml"));
			taskXMLLoader.addEventListener(Event.COMPLETE, processTaskXML);			
		}
		
		private function processTaskXML(e:Event):void 
		{
			var tasksXML : XML = new XML(e.target.data);
			
			var totalTasks : int = tasksXML.task.length();
			
			for (var i : int = 0; i < totalTasks ; i++) {
				var currentTask : Object = tasksXML.task[i];
				var currentDemands : Object = currentTask.demands;
				var taskOutcome : TaskOutcome = new TaskOutcome(xmlListToArray(currentDemands.goodTechnicalDemands), xmlListToArray(currentDemands.goodGenerationDemands), xmlListToArray(currentDemands.goodAmount),
																xmlListToArray(currentDemands.mediumTechnicalDemands), xmlListToArray(currentDemands.mediumGenerationDemands), xmlListToArray(currentDemands.mediumAmount),
																currentTask.goodTime, currentTask.mediumTime, currentTask.badTime,
																currentTask.goodResult, currentTask.mediumResult, currentTask.badResult);
				var newTask : Task = new Task(currentTask.title, currentTask.description, taskOutcome);
				
				tasks.push(newTask);
			}
		}
		
		public function get tasks():Array 
		{
			return _tasks;
		}
		
		public function xmlListToArray($x:XMLList):Array {   		
			var a:Array=[], i:String;
			for (i in $x) a[i] = $x[i];
			return a;
		}
		
		
		
		
		
	}

}