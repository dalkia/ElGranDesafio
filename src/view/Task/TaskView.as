package view.Task 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import model.Profile;
	import model.Task;
	import controller.SimulationManager;
	import controller.ViewManager;
	import view.CompleteTaskItem;
	/**
	 * ...
	 * @author Juanola
	 */
	public class TaskView extends MovieClip
	{
		

		private var profiles : Array;
		private var positions : Array;
		
		private var _task : Task;
		
		private var tick : Bitmap;
		private var currentIcons : Array;
		private var currentMovieClips : Array;
		
		private var origin : CompleteTaskItem;
				
		public function TaskView(task : Task, taskComplete : Boolean, origin : CompleteTaskItem) 
		{
			super();
			positions = new Array(28, 143, 258.3, 373);
			if (!taskComplete) {
				var loader : Loader = new Loader();
				loader.load(new URLRequest("../resources/tick.png"));
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onTickLoadComplete);
				_task = task;
				title_txt.text = task.title;
				description_txt.text = task.description;		
				profiles = SimulationManager.getInstance().getCurrentLazyProfiles()
				currentIcons = new Array();
				currentMovieClips = new Array();
				for (var i : int = 0; i < profiles.length; i++) {
					var containerMovieClip : MovieClip = new MovieClip();
					var icon : Bitmap = new Bitmap(profiles[i].image.bitmapData.clone());
					currentIcons.push(icon);
					icon.width = 73.00;
					icon.height = 92.1;
					containerMovieClip.addChild(icon);
					containerMovieClip.x = positions[i];
					containerMovieClip.y = 248.95;		
					containerMovieClip.userData = [false, profiles[i]];
					containerMovieClip.addEventListener(MouseEvent.CLICK, toogleSelection);
					currentMovieClips.push(containerMovieClip);
					addChild(containerMovieClip);
				}
				startTask_mc.addEventListener(MouseEvent.CLICK, startTask);
				removeChild(closeTask_mc);
			}else {
				removeChild(startTask_mc);
				title_txt.text = task.title;
				sendTo_txt.text = "Hecho por:"
				description_txt.text = task.description + "\n" + task.taskOutcome.resultString;	
				var positionCounter : int = 0;
				for each(var profileTA : Profile in task.peopleSelected) {
					var icon : Bitmap = new Bitmap(profileTA.image.bitmapData.clone());
					icon.x = positions[positionCounter];
					icon.y = 248.95;
					positionCounter++;
					addChild(icon);
				}
				this.origin = origin;
				closeTask_mc.addEventListener(MouseEvent.CLICK, closeTask);
			}
			
		}
		
		private function closeTask(e:MouseEvent):void 
		{
			origin.removeTask(this);
		}
		
		private function onTickLoadComplete(e:Event):void 
		{
			tick = e.currentTarget.content as Bitmap;
		}
		
		private function toogleSelection(e:MouseEvent):void 
		{
			if (!e.currentTarget.userData[0]) {
				e.currentTarget.addChildAt(getSmallTick(),1);
				e.currentTarget.userData[0] = true;
			}else {
				e.currentTarget.removeChildAt(1);
				e.currentTarget.userData[0] = false;
			}		
		}
		
		private function getSmallTick():Bitmap 
		{
			var individualTick : Bitmap = new Bitmap(tick.bitmapData.clone());
			individualTick.width = 30;
			individualTick.height = 30;
			return individualTick;
		}
		
		private function startTask(e:MouseEvent):void 
		{
			var selectedProfiles : Array = new Array();		
			if (currentMovieClips.length > 0) {
				for (var i : int = 0; i < currentMovieClips.length; i++) {				
					if (currentMovieClips[i].userData[0]) {
						selectedProfiles.push(currentMovieClips[i].userData[1]);
					}
					removeChild(currentMovieClips[i]);
					currentIcons[i].bitmapData.dispose();				
					}
				SimulationManager.getInstance().startNewTask(_task, selectedProfiles);
				ViewManager.getInstance().mainSimulationScreen.computer.adminScreen.removeTask();		
			}
	
		}
		
	}
	
	
	
	

}