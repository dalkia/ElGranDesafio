package model.Conversation 
{
	/**
	 * ...
	 * @author Juanola
	 */
	public class PcConversationItem 
	{
		
		private var _conversationItemId : int;
		private var _conversationText : String;
		private var _possibleAnswers : Array;
		
		public function PcConversationItem(conversationItemId : int, conversationText : String, possibleAnswers : Array) 
		{
			_conversationItemId = conversationItemId;
			_conversationText = conversationText;
			_possibleAnswers = possibleAnswers;
		}
		
		public function get conversationText():String 
		{
			return _conversationText;
		}
		
		public function get possibleAnswers():Array 
		{
			return _possibleAnswers;
		}
		
	}

}