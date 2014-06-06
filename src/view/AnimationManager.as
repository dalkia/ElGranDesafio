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
	import controller.SimulationManager;
	import model.HumanProfile;
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
		
		private var _currentAnimation : MovieClip;
		
		private var currentProgressBar : ProgressBar;
		private var currentTotalTime : Number;
		private var currentTime : Number;
		private var currentTimer : Timer;
		private var currentLabel : Label; 		
	
		
		private var _profileMenu : ProfileMenu;
		private var _profileState : ProfileState;
		
		
		
		public function AnimationManager(normalAnimation : MovieClip, happyAnimation : MovieClip, sadAnimation : MovieClip, profileState : ProfileState) 
		{
			_normalAnimation = normalAnimation;
			_happyAnimation = happyAnimation;
			_sadAnimation = sadAnimation;
			_currentAnimation = _normalAnimation;

			_profileMenu = new ProfileMenu(this);
			_profileMenu.x = 450;
			_profileMenu.y = 120;	
			_currentAnimation.addEventListener(MouseEvent.CLICK, showProfileMenu);
			_profileState = profileState;
			
			var format:TextFormat = new TextFormat();
            format.font = "Verdana";
            format.color = 0000000;
            format.size = 16;
			
			currentLabel = new Label();
			currentLabel.setSize(150, 22);
			currentLabel.x = 370;
			currentLabel.y = 185;
			currentLabel.setStyle("textFormat", format);
		}
		
		private function showProfileMenu(e:MouseEvent):void 
		{			
			_currentAnimation.addChild(_profileMenu);			
			ViewManager.getInstance().mainSimulationScreen.addEventListener(MouseEvent.MOUSE_UP, removeProfileMenu);
		}
		
		private function removeProfileMenu(e:MouseEvent):void 
		{			
			ViewManager.getInstance().mainSimulationScreen.removeEventListener(MouseEvent.MOUSE_UP,removeProfileMenu);
			_currentAnimation.removeChild(_profileMenu);
		}
		
		public function addProgressBar(totalTime:Number, activity : String):void 
		{
			currentProgressBar = new ProgressBar();
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
				
	
			currentLabel.text = activity;
			
			_currentAnimation.addChild(currentProgressBar);
			_currentAnimation.addChild(currentLabel);
		}
		
		public function openProfileState():void 
		{		
			_profileState.updateProfileState();
			ViewManager.getInstance().mainSimulationScreen.addChild(_profileState);
			ViewManager.getInstance().mainSimulationScreen.profileStateOn = true;
		}
		
		public function startTraining(newExperience : Number):void 
		{			
			var trainingStarted : Boolean = SimulationManager.getInstance().startTraining(_profileState.profile,newExperience);
			if (trainingStarted) {
				addProgressBar(SimulationManager.getInstance().trainingTime, "CAPACITANDO");
			}
		}
		
		public function updateAnimation(humanProfile : HumanProfile):void 
		{
			_currentAnimation.removeEventListener(MouseEvent.CLICK, showProfileMenu);
			if (humanProfile.getActualPerformance() > 7.5) {
				_currentAnimation = _happyAnimation;
			}else if (humanProfile.getActualPerformance() > 4.0) {
				_currentAnimation = _normalAnimation;				
			}else {
				_currentAnimation = _sadAnimation;
			}
			_currentAnimation.addEventListener(MouseEvent.CLICK, showProfileMenu);
			ViewManager.getInstance().mainSimulationScreen.updateCharacterAnimations();
		}
		
		private function updateProgressBar(e:TimerEvent):void 
		{
			currentTime = currentTime + 1000;
			if (currentTime > currentTotalTime) {
				currentProgressBar.setProgress(currentTotalTime, currentTotalTime);
				currentTimer.stop();
				_currentAnimation.removeChild(currentProgressBar);
				_currentAnimation.removeChild(currentLabel);
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
		
		public function get currentAnimation():MovieClip 
		{
			return _currentAnimation;
		}
		
		public function get profileState():ProfileState 
		{
			return _profileState;
		}
		
	}

}