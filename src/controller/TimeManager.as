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
		
		private var _hourDuration : int;
		private var _currentHour : int;
		private var _hourTimer : Timer;
		
		public function TimeManager(dayDuration : int) {
			_dayDuration = dayDuration * 1000;	
			_hourDuration = _dayDuration / 9;
			_currentDay = 0;
			_currentHour = 1;
		}
		
		public function dayEnded(e : Event):void{
			_currentDay++;			
			_currentHour = 0;
			SimulationManager.getInstance().dayEnded(_currentDay);
		}	
		
		
		public function startTimers():void{
			dayTimer = new Timer(_dayDuration);
			_hourTimer = new Timer(_hourDuration);
			_hourTimer.start();
			_hourTimer.addEventListener(TimerEvent.TIMER, hourEnded);
			dayTimer.start();
			dayTimer.addEventListener(TimerEvent.TIMER, dayEnded);	
		}
		
		public function hourEnded(e : Event):void{
			_currentHour++;					
			SimulationManager.getInstance().hourEndend(_currentHour);
		}	
		
		
		public function endTimers():void {
			dayTimer.stop();
			_hourTimer.stop();
		}
		
		public function get currentDay():int{
			return _currentDay;
		}		
		

	}
	
}
