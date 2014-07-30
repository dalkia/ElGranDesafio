package view 
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import model.Task;
	import view.Task.TaskView;
	/**
	 * ...
	 * @author Juanola
	 */
	public class CompleteTaskItem extends MovieClip
	{
		
		private var task : Task;
		private var taskView : TaskView;
		private var endSimulationScreen : EndSimulationScreen;
		
		public function CompleteTaskItem(task : Task, endSimulationScreen : EndSimulationScreen) 
		{
			super();
			this.task = task;
			taskItem_txt.text = task.description;
			this.endSimulationScreen = endSimulationScreen;
			addEventListener(MouseEvent.CLICK, openTask);
		}
		
		public function removeTask(taskView:TaskView):void 
		{
			endSimulationScreen.removeChild(taskView);
		}
		
		private function openTask(e:MouseEvent):void 
		{
			var taskView : TaskView = new TaskView(task, true, this);
			taskView.x = endSimulationScreen.width / 2 - taskView.width / 2;
			taskView.y = 30;
			endSimulationScreen.addChild(taskView);
		}
		
	}

}