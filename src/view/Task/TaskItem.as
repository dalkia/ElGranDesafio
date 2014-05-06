package view.Task 
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import model.Task;
	import controller.ViewManager;
	/**
	 * ...
	 * @author Juanola
	 */
	public class TaskItem extends MovieClip
	{
		private var _task : Task;
		
		public function TaskItem(task : Task) 
		{
			_task = task;
			taskItem_txt.text = task.title;
			addEventListener(MouseEvent.CLICK, openTask);
		}
		
		private function openTask(e:MouseEvent):void 
		{
			ViewManager.getInstance().mainSimulationScreen.addNewTask(_task);
		}
		
	}

}