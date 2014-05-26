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
		
		public function News(title : String, description : String) 
		{
			_title = title;
			_description = description;
		}
		
		public function get title():String 
		{
			return _title;
		}
		
		public function get description():String 
		{
			return _description;
		}
		
	}

}