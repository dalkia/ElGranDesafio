package model 
{
	/**
	 * ...
	 * @author Juanola
	 */
	public class News 
	{
		
		private var _title : String;
		private var _description : String;
		private var _affection : int;
		
		public function News(title : String, description : String, affection : int) 
		{
			_title = title;
			_description = description;
			_affection = affection;
		}
		
		public function get title():String 
		{
			return _title;
		}
		
		public function get description():String 
		{
			return _description;
		}
		
		public function get affection():int 
		{
			return _affection;
		}
		
		
		
	}

}