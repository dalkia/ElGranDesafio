package view.Mail 
{
	import controller.SimulationManager;
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
		
		public function MailView(conflict : Conflict, answerable : Boolean) 
		{
			super();
			_conflict = conflict;
			from_txt.text = _conflict.owner.name;
			to_txt.text = "Gerente";
			title_txt.text = _conflict.title;
			description_txt.text = _conflict.description;
			if (answerable) {
				startSolution_mc.answer_txt.text = "Responder";
				startSolution_mc.addEventListener(MouseEvent.CLICK, startSolution);
			}else {
				startSolution_mc.answer_txt.text = "Eliminar";
				startSolution_mc.addEventListener(MouseEvent.CLICK, deleteMail);
			}
		}
		
		private function deleteMail(e:MouseEvent):void 
		{
			SimulationManager.getInstance().removeConflict(_conflict);
		}
		
		private function startSolution(e:MouseEvent):void 
		{
			ViewManager.getInstance().mainSimulationScreen.computer.mailScreen.showSolutions(_conflict);
		}
		
	}

}