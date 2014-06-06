package model 
{
	/**
	 * ...
	 * @author Juanola
	 */
	public class Solution 
	{
		
		private var _title:String;
		private var _affection : int;
		private var _nextConflict : int;
		private var _description : String;
		
		public function Solution(title : String, description: String,affection : int, nextConflict : int) 
		{
			_title = title;
			_affection = affection;
			_nextConflict = nextConflict;
			_description = description;
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
		
		public function get affection():int 
		{
			return _affection;
		}
	}

}