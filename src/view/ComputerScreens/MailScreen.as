package view.ComputerScreens 
{
	import fl.containers.ScrollPane;
	import fl.controls.ScrollPolicy;
	import flash.display.MovieClip;
	import model.Conflict;
	import view.Mail.MailItem;
	import view.Mail.MailView;
	import view.Mail.SolutionItem;
	import controller.SimulationManager;
	/**
	 * ...
	 * @author Juanola
	 */
	public class MailScreen extends ComputerScreen 
	{
	
		
		private var mailScrollPane : ScrollPane;
		private var mailExplorer : Boolean;
		
		private var currentMail : MailView;
		
		private var currentSolutions : Array;
		
		public function MailScreen() 
		{
			super();
			mailExplorer = true;
			currentSolutions = new Array;
			mailScrollPane = new ScrollPane();		
			mailScrollPane.horizontalScrollPolicy = ScrollPolicy.OFF;
			mailScrollPane.width = 515.75;
			mailScrollPane.height = 303.10;	
			mailScrollPane.x = 169.85;
			mailScrollPane.y = 102.5;
			addChild(mailScrollPane);			
		}
		
		private function updateMailList():void 
		{
			if (mailExplorer) {
				showEmails();
			}
		}
		
		private function showEmails():void 
		{
			var mailsMovieClips : MovieClip = new MovieClip();
			var activeConflicts : Array = SimulationManager.getInstance().getActiveConflicts();
			for (var i : int = 0; i < activeConflicts.length; i++) {
				var mailItem : MailItem = new MailItem(activeConflicts[i]);
				mailItem.y = mailItem.height * i;
				mailsMovieClips.addChild(mailItem);
			}
			mailScrollPane.source = mailsMovieClips;
			mailScrollPane.update();	
		}
		
		override public function goBackToInitialScreen():void {
			showEmails();			
		}
		
		public function openEmail(conflict:Conflict):void 
		{
			var mailView : MailView = new MailView(conflict, conflict.answereable);
			currentMail = mailView;
			mailScrollPane.source = mailView;
			mailScrollPane.update();
		}
		
		public function showSolutions(conflict:Conflict):void 
		{
			currentMail.from_txt.text = "Gerente";
			currentMail.to_txt.text = conflict.owner.name;
			currentMail.title_txt.text = "Re: " + conflict.title;
			mailScrollPane.update();			
			for (var i : int = 0; i < conflict.solutions.length; i++) {
				var solutionItem : SolutionItem = new SolutionItem(conflict, conflict.solutions[i]);
				if (i == 0) {
					solutionItem.x =  45 + (0) * 334;
					solutionItem.y = 350 + (0) * 107;
					
				}else if (i == 1) {
					solutionItem.x =  45 + (1) * 334;
					solutionItem.y = 350 + (0) * 107;
				}else if (i == 2) {
					solutionItem.x =  45 + (0) * 334;
					solutionItem.y = 350 + (1) * 107;
				}else {
					solutionItem.x =  45 + (1) * 334;
					solutionItem.y = 350 + (1) * 107;
				}		
				currentSolutions.push(solutionItem);
				addChild(solutionItem);
			}
		}
		
		public function removeSolutions():void 
		{
			var currentSolutionsLength : int = currentSolutions.length;
			for (var i : int = 0; i < currentSolutionsLength; i++) {
				removeChild(currentSolutions.pop());
			}
			
		}
		
		override public function closeScreen():void {
			removeSolutions();
		}
		
	}
		
		
}
