package Interface
{
	import flash.display.MovieClip;

	public class BagOfWool extends MovieClip
	{
		// der wollkontainer
		private var woolContainer:MovieClip;
		// der Wollfaden
		private var woolString:MovieClip;
		// das Wollknäuel
		private var wool:MovieClip;
		// die Startzeit
		private var startTime:uint;
		// die Startgröße des Kontainers
		private var startScale:Number = 0.5;
		// die maximale Größe des Kontainers
		private var maxScale:Number = 2;
		// Größenuntschied des Wollknäuels
		private var deltaScale:Number;
		private var isGreen:Boolean = true;
		private var isOrange:Boolean = false;
		private var isRed:Boolean = false;
		
		public function BagOfWool(timeLimit:uint)
		{
			super();
			
			// Startzeit übernehmen
			this.startTime = timeLimit;
			
			// der relative Größenunterschied des Wollknäuels 
			this.deltaScale = this.maxScale - this.startScale;
			
			// Container für Wollknäuel erstellen
			this.woolContainer = new MovieClip();
			this.woolContainer.x = 0;
			this.woolContainer.y = 0;
			this.woolContainer.scaleX = 0.8;
			this.woolContainer.scaleY = 0.8;
			// Wolle anzeigen
			this.addChild(woolContainer);
			
			// mit der grünen Wolle beginnen
			this.woolString = new GreenWoolString();
			this.woolString.gotoAndStop(100);
						
			this.wool = new GreenWool();
			this.wool.scaleX = this.startScale;
			this.wool.scaleY = this.startScale;
			this.woolContainer.addChild(wool);
			
		}
		
		public function scaleAndRotate(newTimeLimit:uint):void{
			if (! woolContainer.contains(this.woolString)){
				woolContainer.addChildAt(this.woolString, 0);
			}
			// Neue Größe des Knäuels berechnen
			var newScale:Number = startScale + (1-(newTimeLimit / startTime)) * deltaScale;
			
			// prüfe, welche farbe die Wolle hat anhand der verstrichenden Zeit
			if (newTimeLimit < int((startTime * 0.66)) && this.isGreen) {
				
				this.isGreen = false;
				this.isOrange = true;
				
				this.woolString = new OrangeWoolString();
				this.woolContainer.addChildAt(woolString, 0);
				this.woolContainer.removeChildAt(1);
				
				this.wool = new OrangeWool();
				this.woolContainer.removeChildAt(1);
				this.woolContainer.addChildAt(wool, 1);
				
			} else if (newTimeLimit < int((startTime * 0.33))&& this.isOrange) {
				
				this.isOrange = false;
				this.isRed = true;
				
				this.woolString = new RedWoolString();
				this.woolContainer.removeChildAt(0);
				this.woolContainer.addChildAt(woolString, 0);
				
				this.wool = new RedWool();
				this.woolContainer.removeChildAt(1);
				this.woolContainer.addChildAt(wool, 1)
			} 
			
			// vergrößere die Wolle
			this.wool.scaleX = newScale;
			this.wool.scaleY = newScale;
			
			// verkleinere den Faden.
			var percent:int = int(Math.ceil(newTimeLimit / this.startTime * 100));
			this.woolString.gotoAndStop(percent);
		}
	}
}