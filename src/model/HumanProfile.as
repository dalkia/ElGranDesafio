package model 
{
	/**
	 * ...
	 * @author Juanola
	 */
	public class HumanProfile 
	{
		
		private var _proactividad : Attribute;
		private var _desmotivacion : Attribute;
		private var _empatia : Attribute;
		private var _conflictividad : Attribute;
		
		
		public function HumanProfile() {
		
			_proactividad = new Attribute("Proactividad ",2);
			_desmotivacion = new Attribute("Desmotivación",2);;
			_empatia = new Attribute("Empatía",2);
			_conflictividad = new Attribute("Conflictividad",2);
		}
		
		public function getActualPerformance():Number {;
			return 0.25 * _proactividad.value + 0.25 * _desmotivacion.value + 0.25 * _empatia.value + 0.25 * _conflictividad.value;
		}
		
		public function get proactividad():Attribute 
		{
			return _proactividad;
		}
		
		public function get desmotivacion():Attribute 
		{
			return _desmotivacion;
		}
		
		public function get empatia():Attribute 
		{
			return _empatia;
		}
		
		public function get conflictividad():Attribute 
		{
			return _conflictividad;
		}
		
	
	
	}

}