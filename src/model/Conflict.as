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
		private var _owner : Profile;
		private var _answereable : Boolean;
		
	
		public function Conflict(id:int, title : String,description : String, penalty : Penalty, possibleSolutions : Array, owner : Profile, answereable : Boolean) 
		{
			_id = id;
			_title = title;
			_description = description;
			_penalty = penalty;
			_solutions = possibleSolutions;
			_owner = owner;
			_answereable = answereable;
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
		
		public function get owner():Profile 
		{
			return _owner;
		}
		
		public function get answereable():Boolean 
		{
			return _answereable;
		}
		
		public function set answereable(value:Boolean):void 
		{
			_answereable = value;
		}
		
		
		
		
		
	}

}