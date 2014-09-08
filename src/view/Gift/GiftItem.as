package view.Gift 
{
	import controller.ViewManager;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import model.Gift;
	/**
	 * ...
	 * @author Juanola
	 */
	public class GiftItem extends MovieClip
	{
		
		private var _gift : Gift;
		
		public function GiftItem(gift : Gift) 
		{
			_gift = gift;
			giftItem_txt.text = gift.name;
			addEventListener(MouseEvent.CLICK, openGift);
		}
		
		private function openGift(e:MouseEvent):void 
		{
			ViewManager.getInstance().mainSimulationScreen.computer.adminScreen.openGiftView(_gift);
		}
		
		
		
	}

}