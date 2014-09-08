package controller 
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	import model.Gift;
	/**
	 * ...
	 * @author Juanola
	 */
	public class GiftManager 
	{
		
		private var _individualGifts : Array;
		private var _globalGifts : Array;
		
		public function GiftManager() 
		{
			_individualGifts = new Array;
			_globalGifts = new Array;
		}
		
		public function loadGifts() {			
			var giftsXMLLoader:URLLoader = new URLLoader();		
			giftsXMLLoader.load(new URLRequest("../resources/xml/Gifts.xml"));			
			giftsXMLLoader.addEventListener(Event.COMPLETE, createGifts);			
		}
		
		public function createGifts(e:Event):void {	
			var giftsXML : XML = new XML(e.target.data);
			var totalGifts : int = giftsXML.gifts.gift.length();
			for (var i : int = 0; i < totalGifts; i++) {				
				var currentGift : Object = giftsXML.gifts.gift[i];				
				var giftType : String = currentGift.type;
				var giftName : String = currentGift.name;
				var description : String = currentGift.description;
				var cost : int = currentGift.cost;
				var image : String = currentGift.image;	
				var results : Dictionary = new Dictionary;
				for (var j : int = 0; j < currentGift.results.result.length(); j++) {
					var currentResult : Object = currentGift.results.result[j];					
					var generation : String = currentResult.generation;
					var affection : int = currentResult.affection;
					results[generation] = affection;
				}
				var gift : Gift = new Gift(giftName, giftType,description, cost, results);
				if (giftType == "Global") {
					_globalGifts.push(gift);
				}else if (giftType == "Individual") {
					_individualGifts.push(gift);
				}
			}				
		}
		
		public function get individualGifts():Array 
		{
			return _individualGifts;
		}
		
		public function get globalGifts():Array 
		{
			return _globalGifts;
		}
		
		
	}

}