package view {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import controller.ViewManager;

	
	public class ProfileMenu extends MovieClip {
		
		private var _animationManager : AnimationManager;
		
		public function ProfileMenu(animationManager : AnimationManager) {		
			_animationManager = animationManager;
			viewProfile_btn.addEventListener(MouseEvent.MOUSE_DOWN, openProfileState);			
			train_btn.addEventListener(MouseEvent.MOUSE_DOWN, train);
			talk_btn.addEventListener(MouseEvent.MOUSE_DOWN, startTalk);
		}
		
		private function startTalk(e:MouseEvent):void 
		{
			ViewManager.getInstance().mainSimulationScreen.startConversation(_animationManager.profileState.profile);
		}
		
		private function train(e:MouseEvent):void 
		{			
			_animationManager.startTraining(0.5);
		}
		
		public function openProfileState(e : MouseEvent):void {
			_animationManager.openProfileState();
		}
		
		
	}
	
}
