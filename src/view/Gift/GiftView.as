package view.Gift 
{
	import controller.SimulationManager;
	import controller.ViewManager;
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import model.Gift;
	/**
	 * ...
	 * @author Juanola
	 */
	public class GiftView extends MovieClip
	{
		private var profiles : Array;
		private var positions : Array;
		
		private var _gift : Gift;
		
		private var tick : Bitmap;
		private var currentIcons : Array;
		private var currentMovieClips : Array;
		
	
				
		public function GiftView(gift : Gift) 
		{
			super();			
			_gift = gift;
			title_txt.text = gift.name;
			description_txt.text = gift.description;	
			cost_txt.text = gift.cost.toString();
			if (gift.giftType == "Individual") {
				positions = new Array(28, 143, 258.3, 373);					
				var loader : Loader = new Loader();
				loader.load(new URLRequest("../resources/tick.png"));
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onTickLoadComplete);
				profiles = SimulationManager.getInstance().getActiveProfiles();
				currentIcons = new Array();
				currentMovieClips = new Array();
				for (var i : int = 0; i < profiles.length; i++) {
					var containerMovieClip : MovieClip = new MovieClip();
					var icon : Bitmap = new Bitmap(profiles[i].image.bitmapData.clone());
					currentIcons.push(icon);
					icon.width = 73.00;
					icon.height = 92.1;
					containerMovieClip.addChild(icon);
					containerMovieClip.x = positions[i];
					containerMovieClip.y = 248.95;		
					containerMovieClip.userData = [false, profiles[i]];
					containerMovieClip.addEventListener(MouseEvent.CLICK, toogleSelection);
					currentMovieClips.push(containerMovieClip);
					addChild(containerMovieClip);
				}
			}else {
				sendTo_txt.text = "";
			}			
			giveGift_mc.addEventListener(MouseEvent.CLICK, giveGift);			
		}		
		
		private function onTickLoadComplete(e:Event):void 
		{
			tick = e.currentTarget.content as Bitmap;
		}
		
		private function toogleSelection(e:MouseEvent):void 
		{		
			if (!e.currentTarget.userData[0]) {
				e.currentTarget.addChildAt(getSmallTick(),1);
				e.currentTarget.userData[0] = true;
			}else {
				e.currentTarget.removeChildAt(1);
				e.currentTarget.userData[0] = false;
			}		
		}
		
		private function getSmallTick():Bitmap 
		{		
			var individualTick : Bitmap = new Bitmap(tick.bitmapData.clone());
			individualTick.width = 30;
			individualTick.height = 30;
			return individualTick;
		}
		
		private function giveGift(e:MouseEvent):void 
		{			
			if (_gift.giftType == "Individual") {
				var selectedProfiles : Array = new Array();			
				for (var i : int = 0; i < currentMovieClips.length; i++) {				
					if (currentMovieClips[i].userData[0]) {
						selectedProfiles.push(currentMovieClips[i].userData[1]);
					}
					removeChild(currentMovieClips[i]);
					currentIcons[i].bitmapData.dispose();				
				}
			}			
			SimulationManager.getInstance().giveGift(_gift, selectedProfiles);			
			ViewManager.getInstance().mainSimulationScreen.computer.adminScreen.removeGift();		
		}
		
	}
	
	
		
	

}