package
Characters {
	import flash.geom.Point;	
	
	import MapElements.Map;	
	import MapElements.Obstacle;			import Characters.Animal;
	import flash.events.MouseEvent;	

	public class Dog extends Animal
	{
		
		
		// Konstruktor
		public function Dog()
		{
			super();
			
			// erzeugt die Movieclips aller Bewegungsanimationen
			moveNorth = new NorthDog();
			moveNorthEast = new NorthEastDog();
			moveEast = new EastDog();
			moveSouthEast = new SouthEastDog();
			moveSouth = new SouthDog();
			moveSouthWest = new SouthWestDog();
			moveWest = new WestDog();
			moveNorthWest = new NorthWestDog();
			//idle = new IdleDog();
			
			// setzt die aktuelle Bewegunsanimation auf bewegungslos
			this.addChild(idle);
			
			//macht das Icon des Hundes braun,
			this.icon.graphics.beginFill(0x0000FF, 1);
			this.icon.graphics.drawCircle(0,0,30);
			this.icon.graphics.endFill();
			this.icon.x = this.x;
			this.icon.y = this.y;
			
		}
		
		public function dogCollision():void {
			var dogPos:Point = level.localToGlobal(new Point(this.x, this.y));
			for each (var obstacle : Obstacle in level.getObstacles()) {
				if (obstacle.hitTestPoint(dogPos.x, dogPos.y, true)) {
					stopMoving();
					break;
				}
			}
		}
		
		public function sendDog(event:MouseEvent):void {
			
			// das Ziel festlegen
			setTarget(event.stageX - level.x, event.stageY- level.y);
			
			// belle:
			sounds.Dog();
		}

	
		
	}
}