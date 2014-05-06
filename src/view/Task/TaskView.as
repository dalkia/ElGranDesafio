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
	import model.Task;
	import controller.SimulationManager;
	import controller.ViewManager;
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
				
		public function TaskView(task : Task) 
		{
			super();
			var loader : Loader = new Loader();
			loader.load(new URLRequest("../resources/tick.png"));
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onTickLoadComplete);
			positions = new Array(28, 143, 258.3, 373);
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