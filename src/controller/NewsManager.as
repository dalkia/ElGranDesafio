package controller 
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import model.News;
	/**
	 * ...
	 * @author Juanola
	 */
	public class NewsManager 
	{
		
		private var _activeNews : Array;
		private var _daysForSimulation : int;
		
		public function NewsManager() 
		{
			_activeNews = new Array();
		}
		
	
		public function createNews() {				
			var newsXMLLoader:URLLoader = new URLLoader();
			newsXMLLoader.load(new URLRequest("../resources/xml/News.xml"));			
			newsXMLLoader.addEventListener(Event.COMPLETE, onXMLNewsLoadComplete);			
		}
		
		private function onXMLNewsLoadComplete(e:Event):void 
		{
			var newsXML : XML = new XML(e.target.data);
			var totalNews : int = newsXML.news.length();
			for (var i : int = 0; i < totalNews; i++) {
				var currentNews : Object = newsXML.news[i];
				var news : News = new News(currentNews.title, currentNews.description, currentNews.affection);
				_activeNews.push(news);
			}
		}
		
		public function get activeNews():Array 
		{
			return _activeNews;
		}
		
	}

}