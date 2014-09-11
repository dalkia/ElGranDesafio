package view.ComputerScreens 
{
	import fl.containers.ScrollPane;
	import fl.controls.ScrollPolicy;
	import flash.display.MovieClip;
	import model.Gift;
	import model.Task;
	import view.Gift.GiftItem;
	import view.Gift.GiftView;
	import view.Task.TaskItem;
	import view.Task.TaskView;
	import controller.SimulationManager;
	import controller.ViewManager;

	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Juanola
	 */
	public class AdminScreen extends ComputerScreen 
	{
		
		private var taskScrollPane : ScrollPane;
		private var scrollPaneAdded : Boolean;
		
		public function AdminScreen() 
		{
			super();
			asignTask_mc.addEventListener(MouseEvent.CLICK, openAsignTaskList);
			individualGift_mc.addEventListener(MouseEvent.CLICK, openIndividualGiftWindow);
			globalGift_mc.addEventListener(MouseEvent.CLICK, openGlobalGiftWindow);
			taskScrollPane = new ScrollPane();
			taskScrollPane.width = 683.85;
			taskScrollPane.height = 401.85;	
			taskScrollPane.horizontalScrollPolicy = ScrollPolicy.OFF;
			scrollPaneAdded = false;
		}
		
		private function openIndividualGiftWindow(e:MouseEvent):void {			
			removeAllButtons();
			createIndividualGiftList();
		}
		
		private function openGlobalGiftWindow(e:MouseEvent):void {			
			removeAllButtons();
			createGlobalGiftList();
		}
		
		private function createIndividualGiftList():void {
			var individualGiftsMC : MovieClip = new MovieClip();	
			var individualGifts : Array = SimulationManager.getInstance().giftManager.individualGifts;
			for (var i : int = 0; i < individualGifts.length; i++) {				
				var giftItem : GiftItem = new GiftItem(individualGifts[i]);
				giftItem.y = giftItem.height * i;
				individualGiftsMC.addChild(giftItem);
				
			}
			taskScrollPane.source = individualGiftsMC;
			taskScrollPane.update();
			addChild(taskScrollPane);
			scrollPaneAdded = true;
			
		}
		
		private function createGlobalGiftList():void {
			var globalGiftsMC : MovieClip = new MovieClip();	
			var globalGifts : Array = SimulationManager.getInstance().giftManager.globalGifts;
			for (var i : int = 0; i < globalGifts.length; i++) {				
				var giftItem : GiftItem = new GiftItem(globalGifts[i]);
				giftItem.y = giftItem.height * i;
				globalGiftsMC.addChild(giftItem);				
			}
			taskScrollPane.source = globalGiftsMC;
			taskScrollPane.update();
			addChild(taskScrollPane);
			scrollPaneAdded = true;
			
		}
	
		
		
		public function openTaskView(task:Task):void 
		{
			var taskView : TaskView = new TaskView(task, false,null);
			taskScrollPane.source = taskView;
			taskScrollPane.update();
			scrollPaneAdded = false;
		}
		
		public function openGiftView(gift:Gift):void 
		{
			var giftView : GiftView =  new GiftView(gift);
			taskScrollPane.source = giftView;
			taskScrollPane.update();
			scrollPaneAdded = false;
		}
		
		public function removeTask():void 
		{
			removeChild(taskScrollPane);		
			createTaskList();
		}
		
		public function removeGift():void 
		{
			removeChild(taskScrollPane);		
			goBackToInitialScreen();
		}
		
		private function openAsignTaskList(e:MouseEvent):void 
		{
			removeAllButtons();
			createTaskList();
		}
		
		public function createTaskList():void 
		{
			var currentTasks : MovieClip = new MovieClip();	
			var tasks : Array = SimulationManager.getInstance().taskManager.tasks;
			for (var i : int = 0; i < tasks.length; i++) {				
				var taskItem : TaskItem = new TaskItem(tasks[i]);
				taskItem.y = taskItem.height * i;
				currentTasks.addChild(taskItem);
			}
			taskScrollPane.source = currentTasks;
			taskScrollPane.update();
			addChild(taskScrollPane);
			scrollPaneAdded = true;
		}
		
		private function removeAllButtons():void 
		{
			removeChild(asignTask_mc);
			removeChild(individualGift_mc);
			removeChild(globalGift_mc);
		}
		
		override public function goBackToInitialScreen():void {
			if (contains(taskScrollPane)) {
				removeChild(taskScrollPane);
			}
			addChild(asignTask_mc);
			addChild(individualGift_mc);
			addChild(globalGift_mc);
		}
		
	}

}