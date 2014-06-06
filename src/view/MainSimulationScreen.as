package view 
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import model.Conversation.ConversationItem;
	import model.News;
	import model.Profile;
	import model.Task;
	import controller.SimulationManager;
	import view.ConversationView.ConversationViewDirector;
	import view.ConversationView.ConversationViewManager;
	/**
	 * ...
	 * @author Juanola
	 */
	public class MainSimulationScreen extends MovieClip 
	{
		
		private var animationCoordinates : Array;
		
		private var _desk : Desk;
		private var _computer : ComputerView;
		private var _newspaper : Newspaper;
		
		private var computerOn : Boolean;
		private var conversationOn : Boolean;
		public var profileStateOn : Boolean;
		private var newspaperOn : Boolean;
		
		private var _conversationViewManager : ConversationViewManager;
		
		public function MainSimulationScreen() 
		{
			super();			
			animationCoordinates = new Array([ -106.7, -60], [ -5.1, -33.85], [92.3, -0.45], [192.1, 48.95]) ;
			_desk = new Desk();
			_desk.x = 150.6;
			_desk.y = 75.5;
			addChild(_desk);
			_newspaper = new Newspaper();
			_computer = new ComputerView();
			computerOn = false;
			conversationOn = false;
			profileStateOn = false;
			newspaperOn = false;
			computerIcon_mc.addEventListener(MouseEvent.CLICK, showComputer);
			smallNewspaper_mc.addEventListener(MouseEvent.CLICK, showNewspaper);
			_conversationViewManager = new ConversationViewManager();
		}
		
		private function showNewspaper(e:MouseEvent):void 
		{
			addChild(_newspaper);
			newspaperOn = true;
		}
		
		private function showComputer(e:MouseEvent):void 
		{
			_computer.showComputer();
			addChild(_computer);
			computerOn = true;
		}
		
				
		public function addCharactersAnimations(characters : Array) {
			for (var i : int = 0; i < characters.length; i++) {
				characters[i].currentAnimation.x = animationCoordinates[i][0];
				characters[i].currentAnimation.y = animationCoordinates[i][1];
				addChild(characters[i].currentAnimation);
			}
			addChild(_desk);
		}
		
		public function closeComputer():void 
		{
			removeChild(_computer);
			computerOn = false;
			updateCharacterAnimations();
		}
	
		
		public function setTotalMoney(totalMoney:Number):void 
		{
			totalMoney_txt.text = "$ " + totalMoney.toString();
		}
		
		public function showProfileMenu(profileMenu:ProfileMenu):void 
		{
			addChild(profileMenu);
			
		}
		
		public function removeProfile(profileState:ProfileState):void 
		{
			removeChild(profileState);
			profileStateOn = false;
			updateCharacterAnimations();
		}
		
		public function setGameOver():void 
		{
			day_txt.text = "Game Over";
		}
		
		public function setDay(day:int):void 
		{
			day_txt.text = "Dia " + day.toString();
		}
		
		public function createNews(currentNews:News, day : int):void 
		{
			_newspaper.setNews(currentNews, day);
		}
		
		
		
		public function closeNewspaper():void 
		{
			removeChild(_newspaper);
			newspaperOn = false;
			updateCharacterAnimations();
		}
		
			
		public function get computer():ComputerView 
		{
			return _computer;
		}
		
		public function setGroupParamaters(proactivity : int, empathy : int, cooperation : int, motivation : int) {
			proactivity_txt.text = proactivity.toString();
			empathy_txt.text = empathy.toString();
			cooperation_txt.text = cooperation.toString();
			motivation_txt.text = motivation.toString();
		}
		
		public function updateCharacterAnimations():void 
		{
			if (!computerOn && !conversationOn && !profileStateOn && !newspaperOn) {
				removeChild(_desk);
				addCharactersAnimations(SimulationManager.getInstance().profileManager.getActiveAnimations());
			}			
		}
		
		public function addConversation(pc1:ConversationViewDirector, currentUserAnswers:Array):void 
		{
			
			addChild(pc1);
			for (var i : int = 0; i < 4; i++) {
				addChild(currentUserAnswers[i]);
			}
			conversationOn = true;
		}
		
		public function startConversation(currentProfile : Profile):void 
		{
			_conversationViewManager.startConversation(currentProfile);
		}
		
		public function closeConversation():void 
		{
			removeChild(_conversationViewManager.currentComputerAnswer);
			for (var i : int = 0; i < 4; i++) {
				removeChild(_conversationViewManager.currentUserAnswers[i]);
			}
			conversationOn = false;
			updateCharacterAnimations();
		}
		
		public function continueConversation(nextItem:int):void 
		{
			_conversationViewManager.updateConversation(nextItem);
		}
		
		
		
	}

}