package view 
{
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import model.Profile;
	import controller.ViewManager;
	
	/**
	 * ...
	 * @author Juanola
	 */
	public class EndSimulationScreenIcon extends MovieClip 
	{
		
		private var profile : Profile;
		
	
		public function EndSimulationScreenIcon(profile:Profile, xPosition : int, yPosition : int) 
		{
			super();
			this.profile = profile;
			this.x = xPosition;
			this.y = yPosition;
			var myClonedIcon:Bitmap = new Bitmap(profile.image.bitmapData.clone());
			addChild(myClonedIcon);
			addEventListener(MouseEvent.CLICK, openProfileState);
		}
		
		private function openProfileState(e:MouseEvent):void 
		{
			
			profile.profileState.updateProfileState();
			ViewManager.getInstance().mainSimulationScreen.addChild(profile.profileState);
			ViewManager.getInstance().mainSimulationScreen.profileStateOn = true;
		}
		
	}

}