package view.ConversationView 
{
	import model.Conversation.Conversation;
	import controller.SimulationManager;
	import controller.ViewManager;
	import model.Conversation.ConversationItem;
	import model.Profile;
	/**
	 * ...
	 * @author Juanola
	 */
	public class ConversationViewManager 
	{
		
		private var _conversation : Conversation;
		
		private var _currentComputerAnswer : ConversationViewDirector;
		private var _currentUserAnswers : Array;
		
		private var _currentProfile : Profile;
		
		public function ConversationViewManager() 
		{
			_conversation = SimulationManager.getInstance().conversation;
			
		}
		
		public function startConversation(currentProfile : Profile):void {
			_currentProfile = currentProfile;
			_currentUserAnswers = new Array();
			var pc1 : ConversationViewDirector = new ConversationViewDirector(_conversation.computerAnswers[0]);
			pc1.x = 50;
			pc1.y = 20;
			
			var u1 : ConversationViewItem = new ConversationViewItem(_conversation.computerAnswers[0].possibleAnswers[0],_currentProfile);
			u1.x = 45;
			u1.y = 350;
			
			var u2 : ConversationViewItem = new ConversationViewItem(_conversation.computerAnswers[0].possibleAnswers[1],_currentProfile);
			u2.x = 45 + 334;
			u2.y = 350;			
			
			var u3 : ConversationViewItem = new ConversationViewItem(_conversation.computerAnswers[0].possibleAnswers[2], _currentProfile);
			u3.x = 45;
			u3.y = 350 + 107;
			
			var u4 : ConversationViewItem = new ConversationViewItem(_conversation.computerAnswers[0].possibleAnswers[3], _currentProfile);
			u4.x = 45 + 334;
			u4.y = 350 + 107;
			
			
			_currentUserAnswers.push(u1);
			_currentUserAnswers.push(u2);
			_currentUserAnswers.push(u3);
			_currentUserAnswers.push(u4);
			
			_currentComputerAnswer = pc1;
			ViewManager.getInstance().mainSimulationScreen.addConversation(pc1, _currentUserAnswers);		
		}
		
		public function updateConversation(nextItem:int):void 
		{
			_currentComputerAnswer.pcConversationItem = _conversation.computerAnswers[nextItem];	
			_currentUserAnswers[0].conversationItem = _conversation.computerAnswers[nextItem].possibleAnswers[0];
			_currentUserAnswers[1].conversationItem = _conversation.computerAnswers[nextItem].possibleAnswers[1];
			_currentUserAnswers[2].conversationItem = _conversation.computerAnswers[nextItem].possibleAnswers[2];
			_currentUserAnswers[3].conversationItem = _conversation.computerAnswers[nextItem].possibleAnswers[3];
		}
		
		public function get currentComputerAnswer():ConversationViewDirector 
		{
			return _currentComputerAnswer;
		}
		
		public function get currentUserAnswers():Array 
		{
			return _currentUserAnswers;
		}
		
	}

}