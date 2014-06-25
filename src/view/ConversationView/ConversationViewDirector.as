package view.ConversationView {
	
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import model.Conversation.PcConversationItem;
	import model.Profile;
	
	
	public class ConversationViewDirector extends MovieClip {
		
		private var _pcConversationItem : PcConversationItem; 
		
		
		public function ConversationViewDirector(pcConversationItem : PcConversationItem, profile : Profile) {
	
			_pcConversationItem = pcConversationItem;
			conversation_txt.text = pcConversationItem.conversationText;
			var profilePicture:Bitmap = new Bitmap(profile.image.bitmapData);
			profilePicture.x = 28;
			profilePicture.y = 6.5;
			profilePicture.width = 101;
			profilePicture.height = 127.35;
			addChild(profilePicture);
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
