package model
{
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author Juanola
	 */
	public class Gift
	{
		
		private var _name:String;
		private var _description:String;
		private var _cost:int;
		private var _giftType:String;
		
		private var _results:Dictionary;
		
		public function Gift(name:String, giftType:String, description:String, cost:int, results:Dictionary)
		{
			_name = name;
			_giftType = giftType;
			_description = description;
			_cost = cost;
			_results = results;
		}
		
		public function getAffectionForProfile(generation:String):int
		{
			return _results[generation];
		}
		
		public function get name():String
		{
			return _name;
		}
		
		public function get description():String
		{
			return _description;
		}
		
		public function get cost():int
		{
			return _cost;
		}
		
		public function get giftType():String 
		{
			return _giftType;
		}
	
	}

}