package view 
{
	import fl.containers.ScrollPane;
	import fl.controls.ScrollPolicy;
	
	import flash.display.MovieClip;
	import model.Profile;
	import model.Task;
	
	/**
	 * ...
	 * @author Juanola
	 */
	public class EndSimulationScreen extends MovieClip 
	{
		
		private var iconPositions : Array;
		private var taskScrollPane : ScrollPane;
		
		public function EndSimulationScreen(profiles:Array, totalMoney:int, totalTeamPoints:int, tasksCompletes : Array ) 
		{
			super();
			iconPositions = new Array(105.45, 253.40, 401.35, 549.3);
			var arrayCounter : int = 0;
			finalTeamPoints_txt.text = totalTeamPoints.toString();
			finalMoney_txt.text = totalMoney.toString();
			for each(var profile : Profile in profiles) {
				var icon : EndSimulationScreenIcon = new EndSimulationScreenIcon(profile,iconPositions[arrayCounter],171.65);
				addChild(icon);
				arrayCounter++;
			}
			taskScrollPane = new ScrollPane();		
			taskScrollPane.horizontalScrollPolicy = ScrollPolicy.ON;
			taskScrollPane.width = 690.85;
			taskScrollPane.height = 184.88;	
			taskScrollPane.x = 36.95;	
			taskScrollPane.y = 332.95;	
			var tasks : MovieClip = new MovieClip();
			var taskCounter : int = 0;
			for each(var taskToCreate : Task in tasksCompletes) {
				var newTask : CompleteTaskItem = new CompleteTaskItem(taskToCreate,this);
				newTask.y = taskCounter * newTask.height;
				tasks.addChild(newTask);
				taskCounter++;
			}
			taskScrollPane.source = tasks;
			addChild(taskScrollPane);
		}
		
	}

}