package model 
{
	/**
	 * ...
	 * @author Juanola
	 */
	public class Attribute 
	{
		
		private var _name : String;
		private var _value : int;
		
		
		public function Attribute(name : String, value : int) 
		{
			_name = name;
			_value = value;
		}
		
		public function get name():String 
		{
			return _name;
		}
		
		public function get value():int 
		{
			return _value;
		}
		
		public function set value(value:int):void 
		{
			_value = value;
		}
		
		
	}

}