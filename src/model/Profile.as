package model 
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import view.AnimationManager;
	import view.ProfileState;
	/**
	 * ...
	 * @author Juanola
	 */
	public class Profile 
	{
		
		private var _technicalProfile : TechnicalProfile;
		private var _humanProfile : HumanProfile;
		private var _experiencie : int;
		private var _name : String;
		private var _description : String;
		private var _age : String;
		private var _salary : int;
		
		private var _imageLoader : Loader;
		private var _image : Bitmap;
		
		private var _animationManager : AnimationManager;
		
		private var _active: Boolean;
		private var _lazy : Boolean;
		
		private var _profileState : ProfileState;
		
		private var _conflictsForDay : Array;
		private var _pendingConflicts : Array;
		
		public function Profile(name:String, age:String, description:String, technicalProfile:String,
								technicalAbilities:Object, imageLoader:Loader, generation : String) 
		{
			_name = name;
			_age = age;
			_description = description;
			_technicalProfile = new TechnicalProfile(technicalProfile, technicalAbilities);
			_humanProfile = new HumanProfile(generation);
			_imageLoader = imageLoader;
			_active = true;
			_lazy = true;
			
			_profileState = new ProfileState(this);
		}
		
		public function onImageLoaded():void {
			_image = _imageLoader.content as Bitmap;
		}
		
		public function get image():Bitmap 
		{
			return _image;
		}
		
		public function get name():String 
		{
			return _name;
		}
		
		public function get humanProfile():HumanProfile 
		{
			return _humanProfile;
		}
		
		public function get technicalProfile():TechnicalProfile 
		{
			return _technicalProfile;
		}
		
		public function get age():String 
		{
			return _age;
		}
		
		public function get description():String 
		{
			return _description;
		}
		
		public function get active():Boolean 
		{
			return _active;
		}
		
		public function get animationManager():AnimationManager 
		{
			return _animationManager;
		}
		
		public function get lazy():Boolean 
		{
			return _lazy;
		}
		
		public function set lazy(value:Boolean):void 
		{
			_lazy = value;
		}
		
		public function get profileState():ProfileState 
		{
			return _profileState;
		}
		
		public function set animationManager(value:AnimationManager):void 
		{
			_animationManager = value;
		}
		
		public function get conflictsForDay():Array 
		{
			return _conflictsForDay;
		}
		
		public function get pendingConflicts():Array 
		{
			return _pendingConflicts;
		}
		
		public function set conflictsForDay(value:Array):void 
		{
			_conflictsForDay = value;
		}
		
		public function set pendingConflicts(value:Array):void 
		{
			_pendingConflicts = value;
		}
		/*
		public function increaseNegativeAttributes():void {
			if (humanProfile.conflictividad.value > 1) {
				humanProfile.conflictividad.value--;
			}
			if (humanProfile.desmotivacion.value > 1) {
				humanProfile.desmotivacion.value--;
			}
			
		}
		*/
		public function increasePositiveAttributes():void {
			if (humanProfile.empatia.value < 4) {
				humanProfile.empatia.value++;
			}
			if (humanProfile.proactividad.value < 4) {
				humanProfile.proactividad.value++;
			}
		}
		
		public function getActualProfileState():ProfileState 
		{
			_profileState.updateProfileState()
			return _profileState;
		}
		
	}

}