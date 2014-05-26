package view.ComputerScreens 
{
	import fl.containers.ScrollPane;
	import fl.controls.ScrollPolicy;
	import flash.display.MovieClip;
	import model.Task;
	import view.Task.TaskItem;
	import view.Task.TaskView;
	import controller.SimulationManager;

	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Juanola
	 */
	public class AdminScreen extends ComputerScreen 
	{
		
		private var taskScrollPane : ScrollPane;
		private var scrollPaneAdded : Boolean;
		
		public function AdminScreen() 
		{
			super();
			asignTask_mc.addEventListener(MouseEvent.CLICK, openAsignTaskList);
			taskScrollPane = new ScrollPane();
			taskScrollPane.horizontalScrollPolicy = ScrollPolicy.ON;
			taskScrollPane.width = 683.85;
			taskScrollPane.height = 401.85;	
			scrollPaneAdded = false;
		}
		
		public function openTaskView(task:Task):void 
		{
			var taskView : TaskView = new TaskView(task);
			taskScrollPane.source = taskView;
			taskScrollPane.update();
		}
		
		public function removeTask():void 
		{
			removeChild(taskScrollPane);		
			createTaskList();
		}
		
		private function openAsignTaskList(e:MouseEvent):void 
		{
			removeAllButtons();
			createTaskList();
		}
		
		public function createTaskList():void 
		{
			var currentTasks : MovieClip = new MovieClip();	
			var tasks : Array = SimulationManager.getInstance().taskManager.tasks;
			for (var i : int = 0; i < tasks.length; i++) {				
				var taskItem : TaskItem = new TaskItem(tasks[i]);
				taskItem.y = taskItem.height * i;
				currentTasks.addChild(taskItem);
			}
			taskScrollPane.source = currentTasks;
			taskScrollPane.update();
			addChild(taskScrollPane);
			scrollPaneAdded = true;
		}
		
		private function removeAllButtons():void 
		{
			removeChild(asignTask_mc);
			removeChild(globalAction_mc);
		}
		
		override public function goBackToInitialScreen():void {
			if (scrollPaneAdded) {
				removeChild(taskScrollPane);
			}
			addChild(asignTask_mc);
			addChild(globalAction_mc);
		}
		
	}

}