package view.Mail 
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import model.Conflict;
	import controller.ViewManager;
	/**
	 * ...
	 * @author Juanola
	 */
	public class MailItem extends MovieClip
	{
		
		private var _conflict : Conflict;
		
		public function MailItem(conflict : Conflict) 
		{
			_conflict = conflict;
			mailItem_txt.text = _conflict.title;
			addEventListener(MouseEvent.CLICK, openMail);
		}
		
		private function openMail(e:MouseEvent):void 
		{
			ViewManager.getInstance().mainSimulationScreen.computer.mailScreen.openEmail(_conflict);
		}
		
	}

}