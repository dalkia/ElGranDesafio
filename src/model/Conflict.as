package model 
{
	/**
	 * ...
	 * @author Juanola
	 */
	public class Conflict 
	{
		
		private var _title : String;
		private var _description : String;		
		private var _solutions : Array;
		private var _penalty : Penalty;
		private var _id : int;
		private var _owner : String;
		
		
		public function Conflict(id:int, title : String,description : String, penalty : Penalty, possibleSolutions : Array) 
		{
			_id = id;
			_title = title;
			_description = description;
			_penalty = penalty;
			_solutions = possibleSolutions;
		}
		
		public function get description():String{
			return _description;
		}
		
		public function get penalty() : Penalty {
			return _penalty;
		}
		
		public function get title() : String {
			return _title;
		}
		
		public function get id() : int {
			return _id;
		}
		
		public function get solutions() : Array {
			return _solutions;
		}
		
		public function get owner():String 
		{
			return _owner;
		}
		
		public function set owner(value:String):void 
		{
			_owner = value;
		}
		
	}

}