package controller 
{
	/**
	 * ...
	 * @author Juanola
	 */
	import controller.SimulationManager;
	import flash.events.*;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import model.Conflict;
	import model.Penalty;
	import model.Solution;
	
	public class ConflictManager 
	{
		
		private var _interConflicts : XML;
		
		
		public function ConflictManager() 
		{
			
		}
		
		public function createConflicts() {				
			var conflictsXMLLoader:URLLoader = new URLLoader();			
			conflictsXMLLoader.load(new URLRequest("../resources/xml/Conflicts.xml"));			
			conflictsXMLLoader.addEventListener(Event.COMPLETE, createPersonalConflicts);			
		}
		
		public function loadInterpersonalConflicts() {				
			var conflictsXMLLoader:URLLoader = new URLLoader();			
			conflictsXMLLoader.load(new URLRequest("../resources/xml/InterConflicts.xml"));			
			conflictsXMLLoader.addEventListener(Event.COMPLETE, interPersonalConflictsLoaded);			
		}
		
		public function interPersonalConflictsLoaded(e:Event):void {
			_interConflicts =  new XML(e.target.data);
		}
		
		public function createPersonalConflicts(e:Event):void {	
			var conflictsXML : XML = new XML(e.target.data);
			var totalConflictsOwners : int = conflictsXML.conflicts.length();
			for (var k : int = 0; k < totalConflictsOwners; k++) {
				var conflictsLength : int = conflictsXML.conflicts[k].conflict.length();
				var conflictsForDay : Array = create10DayArray();
				var pendingConflicts : Array = new Array();
				for (var i : int = 0; i < conflictsLength; i++) {
					var currentConflict = conflictsXML.conflicts[k].conflict[i];
					var currentPenalty = currentConflict.penalty;						
					var penalty : Penalty = new Penalty(currentPenalty.proactivity, currentPenalty.stress);						
					var solutions : Array = new Array;
					for (var j : int = 0; j < currentConflict.solutions.solution.length(); j++) {
						var solution : Solution = new Solution(currentConflict.solutions.solution[j].title,currentConflict.solutions.solution[j].description,currentConflict.solutions.solution[j].incomeModifier,currentConflict.solutions.solution[j].nextConflict); 
						solutions.push(solution);
					}
					var conflict : Conflict = new Conflict(currentConflict.@id, currentConflict.title, currentConflict.description,penalty, solutions);
					if (currentConflict.@autoActivated == "true") {						
						conflictsForDay[currentConflict.day].push(conflict);
					}else{
						pendingConflicts.push(conflict);
					}
				}
				SimulationManager.getInstance().profileManager.addConflicts(conflictsXML.conflicts[k].@owner, conflictsForDay, pendingConflicts);
			}				
		}
		
		private function create10DayArray():Array 
		{
			var arrayAux : Array = new Array();
			for (var i : int = 0; i < 10; i++) {
				arrayAux.push(new Array());
			}
			return arrayAux;
		}
		
		public function createInterPersonalConflicts(names : Array):void{			
			var nameArray : Array = new Array();
			for(var i : int = 0;i<names.length;i++){
				nameArray.push(names[i].profileName);
				
			}
			for each(var profileNameToAnalize : String in nameArray){
				var conflictsLength : int = _interConflicts.conflicts.(@owner==profileNameToAnalize).conflict.length();
				for (var i : int = 0; i < conflictsLength; i++) {
					var currentConflict = _interConflicts.conflicts.(@owner == profileNameToAnalize).conflict[i];					
					if(nameArray.indexOf(new String(currentConflict.@against)) >= 0){
						var currentPenalty = currentConflict.penalty;						
						var penalty : Penalty = new Penalty(currentPenalty.proactivity, currentPenalty.stress);						
						var solutions : Array = new Array;
						for (var j : int = 0; j < currentConflict.solutions.length; j++) {
							var solution : Solution = new Solution(currentConflict.solutions[j].title, currentConflict.solutions[j].description,currentConflict.solutions[j].incomeModifier, currentConflict.solutions[j].nextConflict); 
							solutions.push(solution);
						}
						var conflict : Conflict = new Conflict(currentConflict.@id, currentConflict.title, currentConflict.description, penalty, solutions);
						if (currentConflict.@autoActivated == "true") {						
							SimulationManager.getInstance().profileManager.addConflict(_interConflicts.conflicts.@owner, currentConflict.day,currentConflict);							
						}else {
							SimulationManager.getInstance().profileManager.addPendingConflict(_interConflicts.conflicts.@owner, currentConflict.day,currentConflict);
						}
					}
						
				}				
			}
		}
		
	}

}