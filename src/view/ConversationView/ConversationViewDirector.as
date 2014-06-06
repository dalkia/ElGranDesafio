package view.ConversationView {
	
	import flash.display.MovieClip;
	import model.Conversation.PcConversationItem;
	
	
	public class ConversationViewDirector extends MovieClip {
		
		private var _pcConversationItem : PcConversationItem; 
		
		public function ConversationViewDirector(pcConversationItem : PcConversationItem) {
			_pcConversationItem = pcConversationItem;
			conversation_txt.text = pcConversationItem.conversationText;
		}
		
		public function get pcConversationItem():PcConversationItem 
		{
			return _pcConversationItem;
		}
		
		public function set pcConversationItem(value:PcConversationItem):void 
		{
			_pcConversationItem = value;
			conversation_txt.text = pcConversationItem.conversationText;
		}
	}
	
}
