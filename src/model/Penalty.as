package model {
	
	public class Penalty {
		
		var _proactivityPenalty : int;
		var _stressPenalty : int;
		
		public function Penalty(proactivityPenalty : int, stressPenalty : int) {
			_proactivityPenalty = proactivityPenalty;
			_stressPenalty = stressPenalty;
		}
		
		public function get proactivityPenalty() : int {
			return _proactivityPenalty;
		}
		
		public function get stressPenalty() : int {
			return _stressPenalty;
		}

	}
	
}
