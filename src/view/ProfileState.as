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
	public class ProfileState extends MovieClip 
	{
		
		private var _profile : Profile;
		private var _firstTime : Boolean;
		
		
		public function ProfileState(profile : Profile) 
		{
			super();
			_profile = profile;
			_firstTime = true;
		}
		
		private function closeProfile(e:MouseEvent):void 
		{
			ViewManager.getInstance().mainSimulationScreen.removeProfile(this);
		}
		
		public function updateProfileState():void 
		{
			if (_firstTime) {
				name_txt.text = _profile.name;
				age_txt.text = _profile.age;
				technicalType_txt.text = _profile.technicalProfile.type;
				tech1_txt.text = _profile.technicalProfile.mainAttribute.name;
				tech2_txt.text = _profile.technicalProfile.secondAttribute.name;
				tech3_txt.text = _profile.technicalProfile.thirdAttribute.name;
				tech4_txt.text = _profile.technicalProfile.fourthAttribute.name;
				var image : Bitmap = new Bitmap(_profile.image.bitmapData.clone());
				image.x = 151.9;
				image.y = 350, 1;
				addChild(image);
				closeProfile_mc.addEventListener(MouseEvent.CLICK, closeProfile);
				_firstTime = false;
			}			
			
			tech1_mc.gotoAndStop(_profile.technicalProfile.mainAttribute.value);
			tech2_mc.gotoAndStop(_profile.technicalProfile.secondAttribute.value);
			tech3_mc.gotoAndStop(_profile.technicalProfile.thirdAttribute.value);
			tech4_mc.gotoAndStop(_profile.technicalProfile.fourthAttribute.value);
			human1_mc.gotoAndStop(_profile.humanProfile.proactividad.value);
			human2_mc.gotoAndStop(_profile.humanProfile.desmotivacion.value);
			human3_mc.gotoAndStop(_profile.humanProfile.empatia.value);
			human4_mc.gotoAndStop(_profile.humanProfile.conflictividad.value);
		}
		
	}

}