package model {
	
	public class Penalty {
		
		private var _affection : int;
		
		public function Penalty(affection : int) {
			_affection = affection;
		}
		
		public function get affection():int 
		{
			return _affection;
		}
		
	}
	
}
