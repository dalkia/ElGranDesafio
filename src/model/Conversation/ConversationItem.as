package model.Conversation 
{
	/**
	 * ...
	 * @author Juanola
	 */
	public class ConversationItem 
	{
		
		private var _conversationText : String;
		private var _nextItem : int;
		private var _type : String;
		private var _affection : int;
		
		public function ConversationItem(conversationText : String, nextItem : int, type : String, affection : int) 
		{
			_conversationText = conversationText;
			_nextItem = nextItem;
			_type = type;
			_affection = affection;
		}
		
		public function get conversationText():String 
		{
			return _conversationText;
		}
		
		public function get nextItem():int 
		{
			return _nextItem;
		}
		
		public function get type():String 
		{
			return _type;
		}
		
		public function get affection():int 
		{
			return _affection;
		}
		
	}

}