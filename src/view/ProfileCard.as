package view 
{	
	import controller.ProfileManager;
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import com.gskinner.motion.GTween;
	import com.utils.Math2;
	import fl.motion.easing.*;	
	import model.Profile;
	import controller.ViewManager;
	/**
	 * ...
	 * @author Juanola
	 */
	public class ProfileCard extends MovieClip 
	{		
	
		
		private var _container : Sprite;
		private var _angle : Number;
		private var _profile : Profile;
		private var _image : Bitmap;
		private var _profileManager : ProfileManager;
		
		
		
		public function ProfileCard(profile : Profile, profileManager : ProfileManager) 
		{
			super();	
			_profile = profile;
			_profileManager = profileManager;
			name_txt.text = profile.name;
			age_txt.text = profile.age;
			description_txt.text = profile.description;
			job_txt.text = profile.technicalProfile.type;
			//wage_txt.text = profile.wage.toString();
			techSpec1_txt.text = profile.technicalProfile.mainAttribute.name;
			techSpec1_mc.gotoAndStop(profile.technicalProfile.mainAttribute.value + 1);
			techSpec2_txt.text = profile.technicalProfile.secondAttribute.name;
			techSpec2_mc.gotoAndStop(profile.technicalProfile.secondAttribute.value + 1);
			techSpec3_txt.text = profile.technicalProfile.thirdAttribute.name;
			techSpec3_mc.gotoAndStop(profile.technicalProfile.thirdAttribute.value + 1);
			techSpec4_txt.text = profile.technicalProfile.fourthAttribute.name;
			techSpec4_mc.gotoAndStop(profile.technicalProfile.fourthAttribute.value + 1);
			
			_image = profile.image;
			_image.x = 22;
			_image.y = -141.25;
			addChild(_image);
			
			addToTeam_mc.addEventListener(MouseEvent.CLICK, addToTeam);		
			addEventListener(MouseEvent.CLICK, onClick);			
		}
		
		public function set container(container:Sprite) {
			_container = container;
		}
		
	
		
		private function onClick(e:MouseEvent):void {
			//For zooming in
			//var tw:GTween = new GTween(container, 0.8, { rotationY:Math2.toDeg(e.currentTarget.angle + Math.PI / 2), z:100 },
			//											{ease:Exponential.easeInOut } );
			
			var tw:GTween = new GTween(_container, 0.8, { rotationY:Math2.toDeg(e.currentTarget.angle + Math.PI / 2)},
														{ease:Exponential.easeInOut } );
		}
		
		public function addToTeam(e : Event) {	
			var profileAdded : Boolean = _profileManager.addToActiveProfile(_profile);
			if (profileAdded) {
				ViewManager.getInstance().carousel.addSelectedProfile(this);
				if (contains(addToTeam_mc)) {
					removeChild(addToTeam_mc);
				}
			}					
		}
		
		public function disableAdd():void {
			if (contains(addToTeam_mc)) {
				removeChild(addToTeam_mc);
			}
		}
		
		public function activateCard():void 
		{
			addChild(addToTeam_mc);
		}
		
		
		
		public function get angle():Number 
		{
			return _angle;
		}
		
		public function set angle(value:Number):void 
		{
			_angle = value;
		}
		
		public function get image():Bitmap 
		{
			return _image;
		}
		
		public function get profile():Profile 
		{
			return _profile;
		}
		
		
		
		/*
		public function setProactivity(proactivity : int) {
			stats.gotoAndStop(proactivity);
		}
		
		public function setProfileName(nameA : String){
			_name = nameA;
		}
		
		
			
		public function set carouselManager(carouselManager:CarouselManager) {
			_carouselManager = carouselManager;
		}
		
		public function set teamManager(teamManager : TeamManager){
			_teamManager = teamManager;
		}
		
		public function set profile(profile : Profile){
			_profile = profile;
		}
		
		
	}
*/
		
	}

}