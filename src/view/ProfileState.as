package view 
{
	import fl.containers.ScrollPane;
	import fl.controls.ScrollPolicy;
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.text.engine.FontPosture;
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
		private var giftScrollPane : ScrollPane;
		
		
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
				image.x = 71.25;
				image.y = 375.50;
				addChild(image);
				closeProfile_mc.addEventListener(MouseEvent.CLICK, closeProfile);
				giftScrollPane = new ScrollPane();		
				giftScrollPane.horizontalScrollPolicy = ScrollPolicy.OFF;
				giftScrollPane.width = 230;
				giftScrollPane.height = 135;
				giftScrollPane.x = 218;	
				giftScrollPane.y = 393;	
				addChild(giftScrollPane);
				_firstTime = false;
			}			
			experience_txt.text = _profile.technicalProfile.experience.toString();
			tech1_mc.gotoAndStop(_profile.technicalProfile.mainAttribute.value + 1);
			tech2_mc.gotoAndStop(_profile.technicalProfile.secondAttribute.value  + 1);
			tech3_mc.gotoAndStop(_profile.technicalProfile.thirdAttribute.value  + 1);
			tech4_mc.gotoAndStop(_profile.technicalProfile.fourthAttribute.value  + 1);
			human1_mc.gotoAndStop(_profile.humanProfile.proactividad.value  + 1);
			human2_mc.gotoAndStop(_profile.humanProfile.motivacion.value  + 1);
			human3_mc.gotoAndStop(_profile.humanProfile.empatia.value  + 1);
			human4_mc.gotoAndStop(_profile.humanProfile.cooperacion.value  + 1);
			buildGiftList();
		}
		
		private function buildGiftList():void 
		{
			var giftContainer : MovieClip = new MovieClip;
			for (var i : int = 0; i < _profile.gifts.length;i++) {
				var giftResult : GiftResult = new GiftResult();
				giftResult.giftResult_txt.text = _profile.gifts[i];
				giftResult.y = 46 * i;
				giftContainer.addChild(giftResult);
			}
			giftScrollPane.source = giftContainer;
			giftScrollPane.update();
		}
		
		public function get profile():Profile 
		{
			return _profile;
		}
		
	}

}