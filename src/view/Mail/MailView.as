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
	public class MailView extends MovieClip 
	{
		private var _conflict : Conflict;
		
		public function MailView(conflict : Conflict) 
		{
			super();
			_conflict = conflict;
			from_txt.text = _conflict.owner;
			to_txt.text = "Gerente";
			title_txt.text = _conflict.title;
			description_txt.text = _conflict.description;
			startSolution_mc.addEventListener(MouseEvent.CLICK, startSolution);
		}
		
		private function startSolution(e:MouseEvent):void 
		{
			ViewManager.getInstance().mainSimulationScreen.computer.mailScreen.showSolutions(_conflict);
		}
		
	}

}