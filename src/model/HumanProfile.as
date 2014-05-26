package model 
{
	/**
	 * ...
	 * @author Juanola
	 */
	public class HumanProfile 
	{
		
		private var _proactividad : Attribute;
		private var _motivacion : Attribute;
		private var _empatia : Attribute;
		private var _cooperacion : Attribute;
		private var _generation : String;
		
		
		
		public function HumanProfile(generation : String) {
			_generation = generation;
			_proactividad = new Attribute("Proactividad ",2);
			_motivacion = new Attribute("Motivación",2);;
			_empatia = new Attribute("Empatía",2);
			_cooperacion = new Attribute("Conflictividad",2);
		}
		
		public function getActualPerformance():Number {;
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
		
	
	
	}

}