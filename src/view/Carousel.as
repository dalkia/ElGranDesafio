package view 
{
	import com.gskinner.motion.GTween;
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import com.utils.SimpleZSorter;
	import com.utils.Math2;
	import fl.motion.easing.*;
	import flash.utils.Timer;
	import flash.events.TimerEvent;	
	import model.Profile;
	import view.ProfileCard;
	import controller.SimulationManager;
	public class Carousel extends MovieClip 
	{
		
		private var container: Sprite;
		
		private var anglePer:Number;
		
		private var iconCoordinates : Array;
		private var iconIndex : int;
		
		/*
		public var clock_mc:MovieClip;
		public var carouselView:MovieClip;
		
		private var profiles:Array;
		
		private var selectionDisplay : Array;
		private var currentSelection : int;
		*/
	
		private var availableSpots : Array;
		private var selectedProfileCards : Array;
		private var icons : Array;
		
		public function Carousel() 
		{
			super();			
			init();	
			iconCoordinates = new Array([38.95, 489.5], [144.95, 489.5], [250.95, 489.5], [359.95, 489.5]) ;
			iconIndex = 0;			
			startGame_mc.addEventListener(MouseEvent.CLICK, startSimulation);
			
			firstIndex_mc.addEventListener(MouseEvent.CLICK, removeFirstCharacter);
			secondIndex_mc.addEventListener(MouseEvent.CLICK, removeSecondCharacter);
			thirdIndex_mc.addEventListener(MouseEvent.CLICK, removeThirdCharacter);
			fourthIndex_mc.addEventListener(MouseEvent.CLICK, removeFourthCharacter);
			
			removeChild(firstIndex_mc);
			removeChild(secondIndex_mc);
			removeChild(thirdIndex_mc);
			removeChild(fourthIndex_mc);
			
			availableSpots = new Array();
			availableSpots.push(true);
			availableSpots.push(true);
			availableSpots.push(true);
			availableSpots.push(true);
			
			selectedProfileCards = new Array(4);
			icons = new Array(4);
		
			//initSelectionArray();			
			//this.profiles = profiles;					
			//createTimer();
			
		}
		
		
		private function removeFourthCharacter(e:MouseEvent):void 
		{
			availableSpots[3] = true;
			var profileCard : ProfileCard = selectedProfileCards[3] as ProfileCard;
			SimulationManager.getInstance().profileManager.removeActiveProfile(profileCard.profile);
			profileCard.activateCard();
			removeIcon(3);
			removeChild(fourthIndex_mc);
		}
		
		
		private function removeThirdCharacter(e:MouseEvent):void 
		{
			availableSpots[2] = true;
			var profileCard : ProfileCard = selectedProfileCards[2] as ProfileCard;			
			SimulationManager.getInstance().profileManager.removeActiveProfile(profileCard.profile);
			profileCard.activateCard();
			removeIcon(2);
			removeChild(thirdIndex_mc);
		}
		
		private function removeSecondCharacter(e:MouseEvent):void 
		{
			availableSpots[1] = true;
			var profileCard : ProfileCard = selectedProfileCards[1] as ProfileCard;			
			SimulationManager.getInstance().profileManager.removeActiveProfile(profileCard.profile);
			profileCard.activateCard();
			removeIcon(1);
			removeChild(secondIndex_mc);
		}
		
		private function removeFirstCharacter(e:MouseEvent):void 
		{
			availableSpots[0] = true;
			var profileCard : ProfileCard = selectedProfileCards[0] as ProfileCard;			
			SimulationManager.getInstance().profileManager.removeActiveProfile(profileCard.profile);
			profileCard.activateCard();
			removeIcon(0);
			removeChild(firstIndex_mc);
		}
		
		
		private function startSimulation(e:MouseEvent):void 
		{
			SimulationManager.getInstance().startSimulation();
		}
		
		private function init():void
		{
			container = new Sprite();
			container.x = 800/2;
			container.y = 260;
			container.z = 400;
			addChild(container);				
		//	addEventListener(MouseEvent.CLICK, stageClick);
		}
		
		/*
		public function initSelectionArray(){
			selectionDisplay = new Array(4);
			selectionDisplay[0] = carouselView.firstSelection_txt;
			selectionDisplay[1] = carouselView.secondSelection_txt;
			selectionDisplay[2] = carouselView.thirdSelection_txt;
			selectionDisplay[3] = carouselView.fourthSelection_txt;
			currentSelection = 0;
		}
		
		
		private function createTimer():void {
			clock_mc.timer_txt.text = 60;
			var timer:Timer = new Timer(1000, 60);
			timer.addEventListener(TimerEvent.TIMER, runTimer);
			timer.start();			
		}
		
		function runTimer(e:TimerEvent):void{
			clock_mc.timer_txt.text = clock_mc.timer_txt.text - 1;
		} 
		*/
		public function showCards(profileCards : Array):void {	
			anglePer = (Math.PI * 2) / profileCards.length;					
			for (var i:int = 0; i < profileCards.length; i++) {	
				var pc : ProfileCard  = profileCards[i];
				pc.container = container;				
				pc.angle = (i * anglePer) - Math.PI / 2;
				pc.x = Math.cos(pc.angle ) * 450;
				pc.z = Math.sin(pc.angle ) * 450;				
				pc.rotationY = 360 / profileCards.length * -i;
			//	pc.addEventListener(MouseEvent.CLICK, onClick);
				container.addChild(pc);
			}
			this.addEventListener(Event.ENTER_FRAME, loop);
		}		
		
		public function addSelectedProfile(profileCard:ProfileCard):void 
		{
			var selectedIcon : Bitmap = new Bitmap(profileCard.image.bitmapData.clone());	
			addIcons(profileCard, selectedIcon);
		}
		
		public function disableProfileAdds():void 
		{
			for (var i : int = 0; i < container.numChildren; i++) {
				(container.getChildAt(i) as ProfileCard).disableAdd();
			}
		}
		
		private function addIcons(profile : ProfileCard, selectedIcon : Bitmap):void 
		{
			if (availableSpots[0]) {
				addChild(firstIndex_mc);
				addIcon(0,selectedIcon);
				selectedProfileCards[0] = profile;
				availableSpots[0] = false;
			}else if (availableSpots[1]) {
				addChild(secondIndex_mc);
				addIcon(1,selectedIcon);
				selectedProfileCards[1] = profile;
				availableSpots[1] = false;
			}else if (availableSpots[2]) {
				addChild(thirdIndex_mc);
				addIcon(2,selectedIcon);
				selectedProfileCards[2] = profile;
				availableSpots[2] = false;
			}else {
				addChild(fourthIndex_mc);
				addIcon(3,selectedIcon);
				selectedProfileCards[3] = profile;
				availableSpots[3] = false;
			}
			
		}
		
		
		private function loop(e:Event):void {
			SimpleZSorter.sortClips(container);
		}
		
		private function addIcon(index: int, icon : Bitmap):void {							
			icon.width = 73.00;
			icon.height = 92.1;
			icon.x = iconCoordinates[index][0];
			icon.y = iconCoordinates[index][1];			
			icons[index] = (icon)
			addChild(icon);						
		}
		
		private function removeIcon(number:Number):void 
		{
			removeChild(icons[number]);
		}
		
		/*
		// For zoomin in
		private function onClick(e:MouseEvent):void
		{
			var tw:GTween = new GTween(container, 0.8, {rotationY:Math2.toDeg(e.currentTarget.angle+Math.PI/2), z:100},
														{ease:Exponential.easeInOut});
		}
			
		 // For zooming out
		private function stageClick(e:MouseEvent) {
			var tw:GTween = new GTween(container, 0.8, { z: 400},{ease:Exponential.easeInOut } );			
		}
		
		*/
		
		/*
		public function addProfileToTeam(firstLetter : String) :void {
			selectionDisplay[currentSelection].text = firstLetter;
			currentSelection++;
		}
		*/
		
	}

}