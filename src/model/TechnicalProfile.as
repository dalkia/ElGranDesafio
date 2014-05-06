package model 
{
	/**
	 * ...
	 * @author Juanola
	 */
	public class TechnicalProfile 
	{
		
		private var _type:String;
		private var _mainAttribute : Attribute;
		private var _secondAttribute : Attribute;
		private var _thirdAttribute : Attribute;
		private var _fourthAttribute : Attribute;
				
		public function TechnicalProfile(technicalProfile:String, technicalAbilities:Object) 
		{
			_type = technicalProfile;			
			_mainAttribute = new Attribute(technicalAbilities.mainAttribute.name,technicalAbilities.mainAttribute.value);
			_secondAttribute = new Attribute(technicalAbilities.secondAttribute.name,technicalAbilities.secondAttribute.value);;
			_thirdAttribute = new Attribute(technicalAbilities.thirdAttribute.name,technicalAbilities.thirdAttribute.value);;
			_fourthAttribute = new Attribute(technicalAbilities.fourthAttribute.name,technicalAbilities.fourthAttribute.value);;
		}
		
		public function getActualPerformance():Number {;
			return 0.5 * _mainAttribute.value + 0.3 * _secondAttribute.value + 0.2 * _thirdAttribute.value + 0.1 * _fourthAttribute.value;
		}
		
		public function get type():String 
		{
			return _type;
		}
		
		public function get mainAttribute():Attribute 
		{
			return _mainAttribute;
		}
		
		public function get secondAttribute():Attribute 
		{
			return _secondAttribute;
		}
		
		public function get thirdAttribute():Attribute 
		{
			return _thirdAttribute;
		}
		
		public function get fourthAttribute():Attribute 
		{
			return _fourthAttribute;
		}
		
	}

}