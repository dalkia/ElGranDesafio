package view.Mail 
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import model.Conflict;
	import model.Solution;
	import controller.SimulationManager;
	
	/**
	 * ...
	 * @author Juanola
	 */
	public class SolutionItem extends MovieClip 
	{
		
		private var _conflict : Conflict;
		private var _solution : Solution;
		
		public function SolutionItem(conflict : Conflict, solution : Solution) 
		{
			super();
			_conflict = conflict;
			_solution = solution;
			solution_txt.text = _solution.description;			
			addEventListener(MouseEvent.CLICK, startSolution);
		}
		
		private function startSolution(e:MouseEvent):void 
		{
			SimulationManager.getInstance().startSolution(_solution, _conflict);
		}
		
	}

}