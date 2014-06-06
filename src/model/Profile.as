package model 
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import view.AnimationManager;
	import view.ProfileState;
	import controller.SimulationManager;
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
		
		private var _wage : int;
		
		private var trainingTimer : Timer;
		
		public function Profile(name:String, age:String, description:String, technicalProfile:String,experience : int,
								technicalAbilities:Object, imageLoader:Loader, generation : String, wage : int) 
		{
			_name = name;
			_age = age;
			_description = description;
			_technicalProfile = new TechnicalProfile(technicalProfile, technicalAbilities, experience);
			_humanProfile = new HumanProfile(generation);
			_imageLoader = imageLoader;
			_active = true;
			_lazy = true;
			_wage = wage;
			_profileState = new ProfileState(this);
			
			trainingTimer = new Timer(SimulationManager.getInstance().trainingTime);
			trainingTimer.addEventListener(TimerEvent.TIMER, endTraining);

		}
		
		private function endTraining(e:TimerEvent):void 
		{
			trainingTimer.stop();
			_lazy = true;
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
		
		public function get wage():int 
		{
			return _wage;
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
		public function increasePositiveAttributes(affection : int):void {
			if (affection > 0) {
				for each(var attribute : Attribute in _humanProfile.humanAttributes) {
					if (attribute.value + affection >= 10) {
						attribute.value = 10;
					}else {
						attribute.value = attribute.value + affection;
					}
				}
			}else if(affection < 0) {
				for each(var attribute : Attribute in _humanProfile.humanAttributes) {
					if (attribute.value + affection <= 0) {
						attribute.value = 0;
					}else {
						attribute.value = attribute.value + affection;
					}
				}				
			}
			/*
				if ((humanProfile.empatia.value + affection) > 4) {
					humanProfile.empatia.value = 4;
				}else {
					humanProfile.empatia.value = humanProfile.empatia.value + affection;
				}
				if ((humanProfile.cooperacion.value + affection) >= 3) {
					humanProfile.cooperacion.value = 3;
				}else {
					humanProfile.cooperacion.value = humanProfile.cooperacion.value + affection;
				}
				if ((humanProfile.motivacion.value + affection) >= 3) {
					humanProfile.motivacion.value = 3;
				}else {
					humanProfile.motivacion.value = humanProfile.motivacion.value + affection;
				}
				if ((humanProfile.proactividad.value + affection) >= 3) {
					humanProfile.proactividad.value = 3;
				}else {
					humanProfile.proactividad.value = humanProfile.proactividad.value + affection;
				}
			}else {
				if ((humanProfile.empatia.value + affection) < 0 ) {
					humanProfile.empatia.value = 0;
				}else {
					humanProfile.empatia.value = humanProfile.empatia.value + affection;
				}
				if ((humanProfile.cooperacion.value + affection) < 0 ) {
					humanProfile.cooperacion.value = 0;
				}else {
					humanProfile.cooperacion.value = humanProfile.cooperacion.value + affection;
				}
				if ((humanProfile.motivacion.value + affection) < 0) {
					humanProfile.motivacion.value = 0;
				}else {
					humanProfile.motivacion.value = humanProfile.motivacion.value + affection;
				}
				if ((humanProfile.proactividad.value + affection) < 0) {
					humanProfile.proactividad.value = 0;
				}else {
					humanProfile.proactividad.value = humanProfile.proactividad.value + affection;
				}
			}	
			*/
			updateAnimation();
		}
		
		public function addExperience(newExperience : int):void {
			if (_technicalProfile.experience + newExperience >= 10) {
					_technicalProfile.experience = 10;
			}else {
				_technicalProfile.experience = _technicalProfile.experience + newExperience;
			}
		}
		
		public function addTraining(newTraining : int):void {
		for each(var attribute : Attribute in _technicalProfile.technicalAttributes) {
				if (attribute.value + newTraining >= 10) {
					attribute.value = 10;
				}else {
					attribute.value = attribute.value + newTraining;
				}
			}
		}
		
		public function getActualProfileState():ProfileState 
		{
			_profileState.updateProfileState()
			return _profileState;
		}
		
		public function increaseExp(newExperience:Number):void 
		{
			if (_technicalProfile.experience + newExperience >= 10) {
					_technicalProfile.experience = 10;
				}else {
					_technicalProfile.experience = _technicalProfile.experience + newExperience;
			}
		}
		
		public function startTraining():void 
		{			
			trainingTimer.start();
		}
		
		public function updateAnimation():void 
		{
			_animationManager.updateAnimation(_humanProfile);
		}
		
	}

}