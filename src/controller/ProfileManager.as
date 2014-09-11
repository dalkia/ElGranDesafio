package controller 


{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import fl.events.*;
	import flash.utils.*;
	import model.Conflict;
	import model.Gift;
	import model.Profile;
	import view.AnimationManager;
	import view.ProfileCard;
	import view.ProfileState;
	/**
	 * ...
	 * @author Juanola
	 */
	public class ProfileManager 
	{
		
		private var _profileXML : XML;		
		private var _totalProfiles : int;
		private var _totalProfilesLoaded : int;
		private var _totalConversationsLoaded : int;
		private var _imagesLoaded : Boolean;
		private var _conversationsLoaded : Boolean;

		private var _profiles : Array;
		private var _profileCards : Array;
		
		private var _activeProfiles : Array;
		private var _trainingTimer : Timer;
		
		public function ProfileManager() 
		{
			_activeProfiles = new Array();
			_profiles = new Array();
			_profileCards = new Array();
			
			
		}
		
		public function loadProfiles() {
			var profileXMLLoader:URLLoader = new URLLoader();			
			profileXMLLoader.load(new URLRequest("../resources/xml/Profiles.xml"));
			profileXMLLoader.addEventListener(Event.COMPLETE, processProfilesXML);			
		}
		
		private function processProfilesXML(e:Event):void 
		{
			_profileXML = new XML(e.target.data);
			_totalProfiles = _profileXML.profile.length(); 
			
			_totalProfilesLoaded = 0;
			_totalConversationsLoaded = 0;
			_imagesLoaded = false;
			_conversationsLoaded = false;
			for (var i: int = 0; i < _totalProfiles; i++) {	
				var currentProfile : Object = _profileXML.profile[i];
				
				var imageLoader:Loader = new Loader();			
				imageLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onImageLoadComplete);	
				imageLoader.load(new URLRequest(currentProfile.img));				
				
				var profile : Profile = new Profile(currentProfile.name, currentProfile.age, currentProfile.description,
													currentProfile.technicalProfile,currentProfile.experience ,currentProfile.technicalAbilities,
													imageLoader, currentProfile.generation, currentProfile.wage);
				
				var conversationLoader : ConversationLoader = new ConversationLoader(currentProfile.conversationFile, profile,this);
				var normalAnimation:Class = getDefinitionByName(currentProfile.normalAnimation) as Class;
				var nA:MovieClip = new normalAnimation();
				var happyAnimation:Class = getDefinitionByName(currentProfile.happyAnimation) as Class;
				var hA:MovieClip = new happyAnimation();
				var angryAnimation:Class = getDefinitionByName(currentProfile.angryAnimation) as Class;
				var aA:MovieClip = new angryAnimation();				
				var animationManager : AnimationManager = new AnimationManager(nA, hA, aA, profile.profileState);
				
				profile.animationManager = animationManager;
				
													

													
				_profiles.push(profile);
				
				
				/*
				var proactivity : int = int(profileXML.profile[i].proactivity);
				var stress : int = int(profileXML.profile[i].stress);				
				*/
			}
		}
		
		private function onImageLoadComplete(e:Event):void 
		{			
			_totalProfilesLoaded++;			
			if (_totalProfilesLoaded == _totalProfiles) {
				for (var i : int = 0; i < _totalProfiles; i++) {
					_profiles[i].onImageLoaded();
					var profileCard : ProfileCard = new ProfileCard(_profiles[i],this);
					_profileCards.push(profileCard);	
				}
				_imagesLoaded = true;
				partialLoadComplete();				
			}
		}
		
		public function loadConversationComplete():void 
		{
			_totalConversationsLoaded++;
			if (_totalConversationsLoaded == _totalProfiles) {
				_conversationsLoaded = true;
				partialLoadComplete();
			}
		}
		
		private function partialLoadComplete() {
			if (_conversationsLoaded && _imagesLoaded) {
				SimulationManager.getInstance().profilesLoadComplete();
			}
		}
		
		public function get profileCards():Array 
		{
			return _profileCards;
		}
		
		public function get activeProfiles():Array 
		{
			return _activeProfiles;
		}
		
		
		
		public function addToActiveProfile(profile : Profile):Boolean {
			if (_activeProfiles.length < 4) {
				_activeProfiles.push(profile);
				if (_activeProfiles.length == 4) {
					ViewManager.getInstance().carousel.disableProfileAdds();	
				}
				return true;
			}					
			return false;
			
		}
		
		public function removeActiveProfile(profile : Profile) {			
			
			_activeProfiles.splice(_activeProfiles.indexOf(profile), 1);
			if (_activeProfiles.length == 3) {
				for each(var profile : Profile in _profiles) {
					if (_activeProfiles.indexOf(profile) == -1) {
						(_profileCards[_profiles.indexOf(profile)] as ProfileCard).activateCard();
					}
				}
			}
		}
		
		public function getActiveAnimations():Array {
			var currentAnimation : Array = new Array();
			for each (var profile:Profile in _activeProfiles) {
				if (profile.active) {
					currentAnimation.push(profile.animationManager);
				}
			}
			return currentAnimation;
		}
		
		public function getCurrentLazyProfiles():Array 
		{
			var currentProfileIcons : Array = new Array();
			for each (var profile:Profile in _activeProfiles) {
				if (profile.active && profile.lazy) {
					
					currentProfileIcons.push(profile);
				}
			}
			return currentProfileIcons;
		}
		
		public function addTaskProgressBar(selectedProfiles:Array, totalTime:Number):void 
		{
			for each(var profile:Profile in selectedProfiles) {
				profile.animationManager.addProgressBar(totalTime, "TRABAJANDO");
			}
		}
		
		
		
		public function increasePositiveAtributes(peopleSelected:Array, affection : int):void 
		{
			for (var i : int = 0; i < peopleSelected.length; i++) {
				peopleSelected[i].increasePositiveAttributes(affection);
			}			
			
			
		}
		
		public function addConflicts(name:String, conflictsForDay:Array, pendingConflicts:Array):void 
		{
			for each(var profile : Profile in _profiles) {
				if (profile.name == name) {
					profile.conflictsForDay = conflictsForDay;
					profile.pendingConflicts = pendingConflicts;
				}
			}
		}
		
		public function addConflict(owner:Profile, day:int, conflict:Conflict):void 
		{
			owner.conflictsForDay[day].push(conflict);
		}
		
		public function addPendingConflict(owner:XMLList, day:int,conflict:Conflict):void 
		{
			
		}
		
		public function getConflictsForDay(day : int):Array {
			var conflictsForDay : Array = new Array();
			for (var i : int = 0; i < _activeProfiles.length; i++) {
				for (var j : int = 0; j < _activeProfiles[i].conflictsForDay[day].length; j++) {
					conflictsForDay.push(_activeProfiles[i].conflictsForDay[day][j]);	
				}							
			}
			return conflictsForDay;
		}
		
		public function startTraining(profile:Profile, experience : Number):Boolean 
		{
			if (profile.lazy) {
				profile.addTraining(2);
				profile.increaseExp(experience);
				profile.lazy = false;
				profile.startTraining();
				return true;
			}
			ViewManager.getInstance().mainSimulationScreen.errors_txt.text = "No se puede iniciar una capacitación";	
			Utils.fadeInOut(ViewManager.getInstance().mainSimulationScreen.errors_txt, false);
			return false;
		}
		
		public function getGroupParameters():Array 
		{
			var groupParamaters : Array = new Array();
			var proactivity : Number = 0;
			var empathy : Number = 0;
			var cooperation : Number = 0;
			var motivation : Number = 0;
			for each(var profile : Profile in _activeProfiles) {
				proactivity += profile.humanProfile.proactividad.value;
				empathy += profile.humanProfile.empatia.value;
				cooperation += profile.humanProfile.cooperacion.value;
				motivation += profile.humanProfile.motivacion.value;
			}
			var proactivityInt : int = proactivity / 4;
			var empathyInt : int = proactivity / 4;
			var cooperationInt : int = proactivity / 4;
			var motivationInt : int = proactivity / 4;
			groupParamaters.push(proactivityInt);
			groupParamaters.push(empathyInt);
			groupParamaters.push(cooperationInt);
			groupParamaters.push(motivationInt);
			return groupParamaters;
		}
		
		public function getProfileByName(profileName:String):Profile 
		{
			for each(var profile : Profile in _profiles) {
				if (profile.name == profileName) {
					return profile;
				}
			}
			return null;
		}
		
		public function giveGift(profile:Profile, gift:Gift):int 
		{
			var affection : int = gift.getAffectionForProfile(profile.humanProfile.generation);
			profile.increasePositiveAttributes(affection);
			return affection;
		}
		
		
		
	}

}