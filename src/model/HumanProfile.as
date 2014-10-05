package model 
{
	/**
	 * ...
	 * @author Juanola
	 */
	public class HumanProfile 
	{
		//Podria hacerse una lista mas feliz
		private var _proactividad : Attribute;
		private var _motivacion : Attribute;
		private var _empatia : Attribute;
		private var _cooperacion : Attribute;
		private var _generation : String;
		
		private var _humanAttributes : Array;
		
		public function HumanProfile(generation : String) {
			_generation = generation;
			_humanAttributes = new Array();
			_proactividad = new Attribute("Proactividad ",5);
			_motivacion = new Attribute("Motivación",5);
			_empatia = new Attribute("Empatía",5);
			_cooperacion = new Attribute("Conflictividad", 5);
			_humanAttributes.push(_proactividad);
			_humanAttributes.push(_motivacion);
			_humanAttributes.push(_empatia);
			_humanAttributes.push(_cooperacion);
		}
		
		public function getActualPerformance():Number {
			return 0.25 * _proactividad.value + 0.25 * _motivacion.value + 0.25 * _empatia.value + 0.25 * _cooperacion.value;
		}
		
		public function get proactividad():Attribute 
		{
			return _proactividad;
		}
		
		public function get motivacion():Attribute 
		{
			return _motivacion;
		}
		
		public function get empatia():Attribute 
		{
			return _empatia;
		}
		
		public function get cooperacion():Attribute 
		{
			return _cooperacion;
		}
		
		public function get generation():String 
		{
			return _generation;
		}
		
		public function get humanAttributes():Array 
		{
			return _humanAttributes;
		}
		
		
	
	
	}

}