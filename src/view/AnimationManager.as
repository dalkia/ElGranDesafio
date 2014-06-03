package view 
{

	import fl.controls.Label;
	import fl.controls.ProgressBar;
	import fl.controls.ProgressBarDirection; 
	import fl.controls.ProgressBarMode;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	import controller.ViewManager;
	import model.Profile;
	import view.ProfileMenu;
	/**
	 * ...
	 * @author Juanola
	 */
	public class AnimationManager 
	{
		private var _normalAnimation : MovieClip;
		private var _happyAnimation : MovieClip;
		private var _sadAnimation : MovieClip;
		
		private var currentAnimation : MovieClip;
		
		private var currentProgressBar : ProgressBar;
		private var currentTotalTime : Number;
		private var currentTime : Number;
		private var currentTimer : Timer;
		private var currentLabel : Label; 
		
	
		
		private var _profileMenu : ProfileMenu;
		
		
		public function AnimationManager(normalAnimation : MovieClip, happyAnimation : MovieClip, sadAnimation : MovieClip, profileState : ProfileState) 
		{
			_normalAnimation = normalAnimation;
			_happyAnimation = happyAnimation;
			_sadAnimation = sadAnimation;
			currentAnimation = _normalAnimation;

			_profileMenu = new ProfileMenu(profileState);
			currentAnimation.addEventListener(MouseEvent.CLICK, showProfileMenu);
			
			var format:TextFormat = new TextFormat();
            format.font = "Verdana";
            format.color = 0000000;
            format.size = 16;
			
			currentLabel = new Label();
			currentLabel.setSize(150, 22);
			currentLabel.x = 400;
			currentLabel.y = 185;
			currentLabel.setStyle("textFormat", format);
		}
		
		private function showProfileMenu(e:MouseEvent):void 
		{
			ViewManager.getInstance().mainSimulationScreen.showProfileMenu(_profileMenu);
		}
		
		public function addProgressBar(totalTime:Number):void 
		{
			currentProgressBar = new ProgressBar();
			currentTime = 0;
			currentTotalTime = totalTime;
			
			currentProgressBar.direction = ProgressBarDirection.RIGHT; 
			currentProgressBar.mode = ProgressBarMode.MANUAL; 
			currentProgressBar.width = 170;
			currentProgressBar.height = 40;
			currentProgressBar.x = 342.95;
			currentProgressBar.y = 174;			
						
			
			currentTimer = new Timer(1000);
			currentTimer.addEventListener(TimerEvent.TIMER, updateProgressBar);
			currentTimer.start();	
				
	
			currentLabel.text = "BUSY";
			
			currentAnimation.addChild(currentProgressBar);
			currentAnimation.addChild(currentLabel);
		}
		
		private function updateProgressBar(e:TimerEvent):void 
		{
			currentTime = currentTime + 1000;
			if (currentTime > currentTotalTime) {
				currentProgressBar.setProgress(currentTotalTime, currentTotalTime);
				currentTimer.stop();
				currentAnimation.removeChild(currentProgressBar);
				currentAnimation.removeChild(currentLabel);
			}else {
				currentProgressBar.setProgress(currentTime, currentTotalTime);
			}
			
			
		}
		
		public function get normalAnimation():MovieClip 
		{
			return _normalAnimation;
		}
		
		public function get happyAnimation():MovieClip 
		{
			return _happyAnimation;
		}
		
		public function get sadAnimation():MovieClip 
		{
			return _sadAnimation;
		}
		
	}

}