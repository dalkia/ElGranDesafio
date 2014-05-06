package view 
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import model.Profile;
	import model.Task;
	
	/**
	 * ...
	 * @author Juanola
	 */
	public class MainSimulationScreen extends MovieClip 
	{
		
		private var animationCoordinates : Array;
		
		private var _desk : Desk;
		private var _computer : ComputerView;
		
		public function MainSimulationScreen() 
		{
			super();			
			animationCoordinates = new Array([ -106.7, -60], [ -5.1, -33.85], [92.3, -0.45], [192.1, 48.95]) ;
			_desk = new Desk();
			_desk.x = 150.6;
			_desk.y = 75.5;
			addChild(_desk);
			_computer = new ComputerView();
			computerIcon_mc.addEventListener(MouseEvent.CLICK, showComputer);
		}
		
		private function showComputer(e:MouseEvent):void 
		{
			_computer.showComputer();
			addChild(_computer);
		}
		
		public function addCharactersAnimations(characters : Array) {
			for (var i : int = 0; i < characters.length; i++) {
				characters[i].normalAnimation.x = animationCoordinates[i][0];
				characters[i].normalAnimation.y = animationCoordinates[i][1];
				addChild(characters[i].normalAnimation);
			}
			addChild(_desk);
		}
		
		public function closeComputer():void 
		{
			removeChild(_computer);
		}
		
		public function openAdminScreen():void 
		{
			_computer.openAdminScreen();
		}
		
		public function addNewTask(task : Task):void 
		{
			_computer.openTaskView(task);
		}
		
		public function setTotalMoney(totalMoney:Number):void 
		{
			totalMoney_txt.text = "$ " + totalMoney.toString();
		}
		
		public function showProfileState(profileState:ProfileState):void 
		{
			profileState.updateProfileState();
			addChild(profileState);
		}
		
		public function removeProfile(profileState:ProfileState):void 
		{
			removeChild(profileState);
		}
		
		public function setGameOver():void 
		{
			day_txt.text = "Game Over";
		}
		
		public function setDay(day:int):void 
		{
			day_txt.text = "Dia " + day.toString();
		}
		
		
		
		public function get computer():ComputerView 
		{
			return _computer;
		}
		
		
		
	}

}