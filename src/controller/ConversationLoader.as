package controller 
{
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.events.*;
	import model.Conversation.Conversation;
	import model.Conversation.ConversationItem;
	import model.Conversation.PcConversationItem;
	import model.Profile;
	/**
	 * ...
	 * @author Juanola
	 */
	public class ConversationLoader 
	{
		
		private var profile : Profile;
		private var _profileManager : ProfileManager;
		
		public function ConversationLoader(conversationURL : String, profileToLoadTo : Profile, profileManager : ProfileManager) 
		{
			loadConversation(conversationURL);
			profile = profileToLoadTo;
			_profileManager = profileManager;
		}
		
		public function loadConversation(conversationURL : String) {
			var conversationXMLLoader:URLLoader = new URLLoader();			
			conversationXMLLoader.load(new URLRequest(conversationURL));			
			conversationXMLLoader.addEventListener(Event.COMPLETE, createConversation);			
		}
		
		private function createConversation(e:Event):void 
		{
			var conversationXML : XML = new XML(e.target.data);
			var totalConversationIterations : int = conversationXML.conversationIteration.length();
			var conversation : Array = new Array();
			for (var i : int = 0; i < totalConversationIterations; i++) {
				var currentIteration : Object = conversationXML.conversationIteration[i];
				var possibleAnswers : Array = new Array();
				for (var j : int = 0; j < currentIteration.conversationItem.length();j++) {
					var currentItem : Object = currentIteration.conversationItem[j];
					var conversationItem : ConversationItem;
					if (currentItem.affection != null) {
						conversationItem = new ConversationItem(currentItem.text, currentItem.nextItem, "-1", currentItem.affection);
					}else {
						conversationItem= new ConversationItem(currentItem.text, currentItem.nextItem, "-1", -1);
					}
					possibleAnswers.push(conversationItem);
				}
				var pcConversationItem : PcConversationItem = new PcConversationItem(currentIteration.@id, currentIteration.conversationDirector.text, possibleAnswers);
				conversation.push(pcConversationItem);
			}
			var fullConversation : Conversation = new Conversation(conversation);
			profile.conversation = fullConversation;
			_profileManager.loadConversationComplete();
		}
		
		
		
	}

}