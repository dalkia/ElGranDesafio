package view.ConversationView {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import model.Conversation.ConversationItem;
	import controller.ViewManager;
	import model.Profile;
	
	
	public class ConversationViewItem extends MovieClip {
		
		private var _conversationItem : ConversationItem;
		private var _currentProfile : Profile;
		
		public function ConversationViewItem(conversationItem : ConversationItem, currentProfile : Profile) {
			_conversationItem = conversationItem;
			conversation_txt.text = _conversationItem.conversationText;
			_currentProfile = currentProfile;
			addEventListener(MouseEvent.CLICK, selectedConversation);
		}
		
		private function selectedConversation(e:MouseEvent):void 
		{
			if (_conversationItem.nextItem == -1) {
				ViewManager.getInstance().mainSimulationScreen.closeConversation();
			}else {
				ViewManager.getInstance().mainSimulationScreen.continueConversation(_conversationItem.nextItem);
			}
			if (_conversationItem.affection != -1) {
				_currentProfile.increasePositiveAttributes(_conversationItem.affection);
			}
		}
		
		public function get conversationItem():ConversationItem 
		{
			return _conversationItem;
		}
		
		public function set conversationItem(value:ConversationItem):void 
		{
			_conversationItem = value;
			conversation_txt.text = _conversationItem.conversationText;
		}
	}
	
}
