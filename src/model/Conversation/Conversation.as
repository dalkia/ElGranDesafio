package model.Conversation 
{
	/**
	 * ...
	 * @author Juanola
	 */
	public class Conversation 
	{
		
		var _computerAnswers : Array;
		
		
		public function Conversation(conversation : Array) {
			_computerAnswers = conversation;
		}
		/*
		public function Conversation() 
		{
			var u11 : ConversationItem = new ConversationItem("Buen dia, cuales son sus gustos", 1,"-1",-1);
			var u12 : ConversationItem = new ConversationItem("Buen dia, vengo a motivarlo!", 2,"-1",-1);
			var u13 : ConversationItem = new ConversationItem("Buen dia, vio las noticias hoy?", 3,"-1",-1);
			var u14 : ConversationItem = new ConversationItem("Adios", -1,"-1",-1);
			var uArray1 : Array = new Array(u11, u12, u13, u14);
			var pc1 : PcConversationItem = new PcConversationItem(0, "Buen dia jefe", uArray1);

			var u21 : ConversationItem = new ConversationItem("Que interesante!", -1,"-1",-1);
			var u22 : ConversationItem = new ConversationItem("Que fantastico!", -1,"-1",-1);
			var u23 : ConversationItem = new ConversationItem("Que increible!", -1,"-1",-1);
			var u24 : ConversationItem = new ConversationItem("Adios", -1,"-1",-1);
			var uArray2 : Array = new Array(u21, u22, u23, u24);			
			var pc2 : PcConversationItem = new PcConversationItem(1, "Mis gustos son los siguientes", uArray2);
			
			var u31 : ConversationItem = new ConversationItem("De la correcta", -1,"MotivateB",5);
			var u32 : ConversationItem = new ConversationItem("De la incorrecta", -1,"MotivateM",-1);
			var u33 : ConversationItem = new ConversationItem("De ninguna", -1,"-1",-1);
			var u34 : ConversationItem = new ConversationItem("Adios", -1,"-1",-1);
			var uArray3 : Array = new Array(u31, u32, u33, u34);	
			var pc3 : PcConversationItem = new PcConversationItem(2, "Gracias jefe, de que manera?", uArray3);
			
			
			var u41 : ConversationItem = new ConversationItem("Buena onda usted!", -1,"-1",-1);
			var u42 : ConversationItem = new ConversationItem("Adios", -1,"-1",-1);
			var u43 : ConversationItem = new ConversationItem("Adios", -1,"-1",-1);
			var u44 : ConversationItem = new ConversationItem("Adios", -1,"-1",-1);
			var uArray4 : Array = new Array(u41, u42, u43, u44);	
			var pc4 : PcConversationItem = new PcConversationItem(3, "No las vi, y no quiero hablar de ellas", uArray4);
			
			_computerAnswers = new Array(pc1,pc2,pc3,pc4);
		}
		
		*/
		
		public function get computerAnswers():Array 
		{
			return _computerAnswers;
		}
		
		public function set computerAnswers(value:Array):void 
		{
			_computerAnswers = value;
		}
		
	
		
	}

}