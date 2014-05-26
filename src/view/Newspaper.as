package view 
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import controller.ViewManager;
	import model.News;
	
	/**
	 * ...
	 * @author Juanola
	 */
	public class Newspaper extends MovieClip 
	{
		
		public function Newspaper() 
		{
			super();			
			x = 91.5;
			y = 29.1;		
			closeNewspaper_mc.addEventListener(MouseEvent.CLICK, closeNewspaper);
		}
		
		private function closeNewspaper(e:MouseEvent):void 
		{
			ViewManager.getInstance().mainSimulationScreen.closeNewspaper();
		}
		
		public function setTexts(title : String, date : String, description : String) {
			
			
		}
		
		public function setNews(currentNews:News, day : int):void 
		{
			mainNews_txt.text = currentNews.title + "\n" + currentNews.description;
			var newDay : int = day + 1;
			date_txt.text = "Dia "+  newDay;
		}
		
	}

}