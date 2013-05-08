package Interface
{
	import flash.display.MovieClip;

	public class PointsSign extends MovieClip
	{
		
		private var singleDigit:MovieClip;
		private var decadeDigit:MovieClip;
		
		public function PointsSign()
		{
			super();
			
			// die Instanznamen aus dem Flashprojekt übernehmen
			singleDigit = this.getChildAt(1) as MovieClip;
			decadeDigit = this.getChildAt(0) as MovieClip;
			
			
			singleDigit.gotoAndStop(10);
			decadeDigit.gotoAndStop(10);
		}
		
		public function setPoints(currentPoints:uint):void{
			// berechne die Einer- und Zehnerstelle
			var single:uint = currentPoints % 10;
			var decade:uint = currentPoints - single;
			
			// setzte den Zahlenmoviclip auf den richtigen Frame
			if (single == 0) {
				single = 10;
			}
			if (decade == 0) {
				decade = 10;
			}
			singleDigit.gotoAndStop(single);
			decadeDigit.gotoAndStop(decade);
			
		}
		
	}
}