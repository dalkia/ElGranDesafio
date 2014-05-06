package model 
{
	/**
	 * ...
	 * @author Juanola
	 */
	public class Solution 
	{
		
		private var _title:String;
		private var _incomeModifier : int;
		private var _nextConflict : int;
		private var _description : String;
		
		public function Solution(title : String, description: String,incomeModifier : int, nextConflict : int) 
		{
			_title = title;
			_incomeModifier = incomeModifier;
			_nextConflict = nextConflict;
			_description = description;
		}	
		

		
		public function get incomeModifier() : int {
			return _incomeModifier;
		}
		
		public function get nextConflict() : int{
			return _nextConflict;
		}
		
		public function get description():String 
		{
			return _description;
		}
		
		public function set description(value:String):void 
		{
			_description = value;
		}
		
		public function get title():String 
		{
			return _title;
		}
	}

}