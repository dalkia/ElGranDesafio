package model 
{
	/**
	 * ...
	 * @author Juanola
	 */
	public class TechnicalProfile 
	{
		
		private var _type:String;
		private var _experience : Number;
		private var _mainAttribute : Attribute;
		private var _secondAttribute : Attribute;
		private var _thirdAttribute : Attribute;
		private var _fourthAttribute : Attribute;
		
		private var _technicalAttributes : Array;
				
		public function TechnicalProfile(technicalProfile:String, technicalAbilities:Object, experience : Number) 
		{
			_type = technicalProfile;	
			_experience = experience;
			_technicalAttributes = new Array();
			_mainAttribute = new Attribute(technicalAbilities.mainAttribute.name,technicalAbilities.mainAttribute.value);
			_secondAttribute = new Attribute(technicalAbilities.secondAttribute.name,technicalAbilities.secondAttribute.value);
			_thirdAttribute = new Attribute(technicalAbilities.thirdAttribute.name,technicalAbilities.thirdAttribute.value);
			_fourthAttribute = new Attribute(technicalAbilities.fourthAttribute.name, technicalAbilities.fourthAttribute.value);
			_technicalAttributes.push(_mainAttribute);
			_technicalAttributes.push(_secondAttribute);
			_technicalAttributes.push(_thirdAttribute);
			_technicalAttributes.push(_fourthAttribute);
		}
		
		public function getActualPerformance():Number {;
			return 0.5 * _experience +  0.5 * ((_mainAttribute.value + _secondAttribute.value + _thirdAttribute.value + _fourthAttribute.value)/4);
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
		

		public function get technicalAttributes():Array 
		{
			return _technicalAttributes;
		}
		
		public function get experience():Number 
		{
			return _experience;
		}
		
		public function set experience(value:Number):void 
		{
			_experience = value;
		}
		
	}

}