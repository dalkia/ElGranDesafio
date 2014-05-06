package controller {
	
	import controller.SimulationManager;
	import flash.utils.Timer;
	import flash.events.Event;
	import flash.events.TimerEvent;
	
	public class TimeManager {

		private var _dayDuration : int;
		private var _incomeDuration : int;
		private var currentDayTime : int;
		
		private var dayTimer:Timer;
		private var _currentDay : int;
		
		public function TimeManager(dayDuration : int) {
			_dayDuration = dayDuration * 1000;				
			_currentDay = 0;
		}
		
		public function dayEnded(e : Event):void{
			_currentDay++;		
			SimulationManager.getInstance().dayEnded(_currentDay);
		}
		
		
		
		public function startTimers():void{
			dayTimer = new Timer(_dayDuration);
			dayTimer.start();
			dayTimer.addEventListener(TimerEvent.TIMER, dayEnded);	
		}
		
		public function endTimers():void {
			dayTimer.stop();
		}
		
		public function get currentDay():int{
			return _currentDay;
		}		
		

	}
	
}
