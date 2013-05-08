package{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.system.*;
	import SheepGame;
	import Characters.*;
	import flash.display.Loader;
	import flash.net.URLRequest;
	
	public class Menu extends MovieClip{
		private var startMenu:StartMenu;
		private var credits:Credits;
		private var loader:Loader;
		
		public function Menu(){
			startMenu = new StartMenu();
			credits = new Credits();
			loader = new Loader(),
			startMenu.newGame_btn.addEventListener(MouseEvent.CLICK, onStartClick);
			startMenu.credits_btn.addEventListener(MouseEvent.CLICK, onCreditsClick);
			startMenu.leave_btn.addEventListener(MouseEvent.CLICK, onLeaveClick);
			credits.back_btn.addEventListener(MouseEvent.CLICK, onBackClick);
			
			this.addChild(startMenu);
		}
		
		private function onStartClick(event:MouseEvent):void{
			this.removeChild(startMenu);
			loader.load(new URLRequest("GameLoader.swf"));
			this.removeChildAt(0);
			this.addChild(loader);
		}
		
		private function onCreditsClick(event:MouseEvent):void{
			this.addChild(credits);
			this.removeChild(startMenu);
		}
		
		private function onLeaveClick(event:MouseEvent):void{
			System.exit(0);
		}
		
		private function onBackClick(event:MouseEvent):void{
			this.addChild(startMenu);
			this.removeChild(credits);
		}
	}
}