package model 
{
	import controller.SimulationManager;
	
	/**
	 * ...
	 * @author Juanola
	 */
	public class TaskOutcome 
	{
		
		private var _technicalGoodDemands : Array;
		private var _generationGoodDemands : Array;
		private var _amountGood : Array;
		
		private var _technicalMediumDemands : Array;
		private var _generationMediumDemands : Array;
		private var _amountMedium : Array;
		
		private var _goodTime : int;
		private var _mediumTime : int;
		private var _badTime : int;
		
		private var _goodResult : int;
		private var _mediumResult : int;
		private var _badResult : int;
		
		private var _outcome : Object;
		
		private var _affection : int;
		private var _profilesSelected : Array;
		private var createConflicts : Boolean;
		
		public function TaskOutcome(technicalGoodDemands : Array, generationGoodDemands : Array, amountGood : Array,
									technicalMediumDemands : Array, generationMediumDemands : Array, amountMedium : Array,
									goodTime : int, mediumTime : int, badTime :int,
									goodResult : int, mediumResult : int, badResult : int) 
		{
			this._technicalGoodDemands = technicalGoodDemands;
			this._generationGoodDemands = generationGoodDemands;
			this._amountGood = amountGood;
			
			this._technicalMediumDemands = technicalMediumDemands;
			this._generationMediumDemands = generationMediumDemands;
			this._amountMedium = amountMedium;
			
			this._goodTime = goodTime;
			this._mediumTime = mediumTime;
			this._badTime = badTime;
			
			this._goodResult = goodResult;
			this._mediumResult = mediumResult;
			this._badResult = badResult;
			createConflicts = false;
		}
		
		public function getOutcome(profilesSelected : Array):Object {
			var goodTechnical : Boolean = true;
			var mediumTechnical : Boolean = true;
			var goodGeneration : Boolean = true;
			var mediumGeneration : Boolean = true;
			var goodAmount : Boolean = true;
			var mediumAmount : Boolean = true;
			_profilesSelected = profilesSelected;
			for each(var profile : Profile in profilesSelected) {	
				if (findInArray(profile.technicalProfile.type,_technicalGoodDemands) == -1) {
					goodTechnical = false;
				}
				if (findInArray(profile.technicalProfile.type,_technicalMediumDemands) == -1) {
						mediumTechnical = false;					
				}		
				if (findInArray(profile.humanProfile.generation,_generationGoodDemands) == -1) {
					goodGeneration = false;					
				}
				if (findInArray(profile.humanProfile.generation,_generationMediumDemands) == -1) {
					mediumGeneration = false;					
				}					
			}
			if (findInArray(profilesSelected.length.toString(),_amountGood) == -1) {
				goodAmount = false;
			}
			if (findInArray(profilesSelected.length.toString(),_amountMedium) == -1) {
				mediumAmount = false;
			}
			_outcome = new Object();	
			if (goodTechnical && goodGeneration && goodAmount) {
				outcome.time = _goodTime * 1000;
				var synergy : Number = 0;
				for each(var profile : Profile in profilesSelected) {
					synergy += profile.humanProfile.getActualPerformance() + profile.technicalProfile.getActualPerformance();
				}
				var synergyInt : int = synergy;
				outcome.result = _goodResult + synergyInt;
				_affection = 2;
			}else if (mediumTechnical && mediumGeneration && mediumAmount) {
				outcome.time = _mediumTime * 1000;
				var synergy : Number = 0;
				for each(var profile : Profile in profilesSelected) {
					synergy += profile.humanProfile.getActualPerformance() + profile.technicalProfile.getActualPerformance();
				}
				var synergyInt : int = synergy;
				outcome.result = _mediumResult + synergyInt/2;	
				_affection = 1;
			}else {
				outcome.time = _badTime * 1000;
				outcome.result = _badResult;
				_affection = -1;
				createConflicts = true;				
			}
			return outcome;			
		}
		
		public function get outcome():Object 
		{
			return _outcome;
		}
		
		public function activateOutcome():void{
			SimulationManager.getInstance().affectHumanProfiles(_affection, _profilesSelected);
			if(createConflicts){
				SimulationManager.getInstance().addPoorWorkConflicts(_profilesSelected);
			}
		}
		
		function findInArray(str:String, array : Array):int {
			for(var i:int = 0; i < array.length; i++){
				if(array[i] == str){					
					return i;
				}
			}
			return -1; //If not found
		}
		
		
	}

}