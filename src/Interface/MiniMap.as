package Interface
{
	import Characters.Sheep;
	
	import Events.SheepEvent;
	
	import MapElements.Blocker;
	import MapElements.MapElement;
	import MapElements.Map;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;

	public class MiniMap extends MovieClip
	{
		private var map:Map;
		
		public function MiniMap(map:Map)
		{
			// erzeuge von allen Kartenhindernissen Bitmaps und füge sie der Karte hinzu
			this.map = map;
			var picture:Bitmap;
			var mapChild:DisplayObject;
			for (var i:int = 0; i < map.numChildren; i++) {
				mapChild = map.getChildAt(i);
				if (mapChild is MapElement && !(mapChild is Blocker)) {
					picture = copyBitmap(mapChild);
					//übernehme die Koordinaten der Orgniale
					picture.x = mapChild.x;
					picture.y = mapChild.y;
					this.addChild(picture);
				}
			}
			/*
			for each (var obstacle:MovieClip in map.getObstacles()){
				//ignoriere den Blocker
				if(!(obstacle is Blocker)){
					picture = copyBitmap(obstacle);
					//übernehme die Koordinaten der Orgniale
					picture.x = obstacle.x;
					picture.y = obstacle.y;
					this.addChild(picture);
				}
			}
			*/
			
			// fügt das Icon des Hundes hinzu
			map.getDog().refreshIcon();
			this.addChild(map.getDog().getIcon());
			
			// fügt für alle Schafe ein Icon hinzu
			for each (var sheep:Sheep in map.getSheeps()){
				sheep.refreshIcon();
				this.addChild(sheep.getIcon());
			}		
			
			//skalliere die Karte runter
			this.scaleX = 0.12;
			this.scaleY = 0.12;
			
		}
		
		private function copyBitmap(target: DisplayObject) : Bitmap
		{
		  // Create the bitmap data object with the right size.
		  var data : BitmapData = new BitmapData(target.width, target.height, true, 0);
		  // Draw the target object into the bitmap data.
		  data.draw(target);
		  // Create a new bitmap object associated with this data.
		  var bitmap: Bitmap = new Bitmap(data);
		  return bitmap;
		}
		
		// entfernt ein Schaficon von der Karte
		public function removeSheepIcon(e:SheepEvent):void{
			this.removeChild(e.sheep.getIcon());
			e.sheep.unsetIcon();
		}
		
		//entfernt alle Elemtne von der mini-Map
		public function closeMiniMap():void{
			this.map.getDog().unsetIcon();
			while(this.numChildren > 0){
				this.removeChildAt(0);
			}
		}
		
	}
}