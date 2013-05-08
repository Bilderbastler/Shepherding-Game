package
Characters {
	import Audio.Sounds;
	
	import Events.SheepEvent;
	
	import MapElements.Machine;
	import MapElements.MoleHole;
	import MapElements.Obstacle;
	
	import flash.geom.Point;	
	
	
	public class Sheep extends Animal
	{
		
		// die Fluchtdistanz, die die Schafe zurücklegen
		private const fleeDistance:uint = 200;
		
		public function Sheep()
		{
			super();
			
			// erzeugt die Movieclips aller Bewegungsanimationen
			moveNorth = new NorthSheep();
			moveNorthEast = new NorthEastSheep();
			moveEast = new EastSheep();
			moveSouthEast = new SouthEastSheep();
			moveSouth = new SouthSheep();
			moveSouthWest = new SouthWestSheep();
			moveWest = new WestSheep();
			moveNorthWest = new NorthWestSheep();
			//idle = new IdleSheep();
			
			// setzt die aktuelle Bewegunsanimation auf bewegungslos
			this.addChild(idle);
			
			//macht das Icon des Schafes weiß,
			this.icon.graphics.beginFill(0xFFFFFF, 1);
			this.icon.graphics.drawCircle(0,0,30);
			this.icon.graphics.endFill();
			this.icon.x = this.x;
			this.icon.y = this.y;
		}
		
		// prüfe die Entfernung zum Hund
		public function checkDogDistance():void{
			
			// wenn die entfernung kleiner ist als 30 Punkte
			if (Point.distance(this.getPosition(), level.getDog().getPosition()) < 150) {
				// falls sich das Schaf nicht schon bewegt
				if (this.distanceToTarget == 0) {
					
					// berechne als erste die Differenz zwischen Schaf und Hund
					var escapePoint:Point = getPosition().subtract(level.getDog().getPosition());
					// addiere dann die Diffenz auf die Position des Schafes
					escapePoint = this.getPosition().add(escapePoint);
										
					// setzte die Strecke, die das Schaf flüchten soll
					distanceToTarget = fleeDistance;
					
					// setzte den Flucht-Punkt als neues Ziel
					this.target = escapePoint;
					
					// und schicke das Vieh auf die Reise
					startMovingAnimal();
					
					// und versuche zu blöken:
					this.sounds.Sheep();
					
				}
			}  
		}
	
		// prüft, ob das Schaf gegen ein Hinderniss oder ein anderes Schaf läuft
		public function checkCollisionSheep(index:int):void {
			// berechne Position des Schafs auf der Karte:
			var sheepPos:Point = level.localToGlobal(new Point(this.x, this.y));
			/*
			// wenn sich das Schaf bewegt...
			if (this.distanceToTarget > 0){
				// ...gehe alle Schafe durch
				for each (var sheep : Sheep in level.getSheeps()) {
					// wenn sich die Schafe treffen 
					if (this != sheep && sheep.hitTestPoint(sheepPos.x, sheepPos.y) ) {
						// halte das Schaf an
						this.stopMoving();
						//TODO Schafherde bilden, wenn ein Zusammenstoß stattfindet
					}
				}
			}
			 */
			 
			// gehe alle Hindernisse durch
			for each (var obstacle : Obstacle in level.getObstacles()) {
				// prüfe Kollision
				if (obstacle.hitTestPoint(sheepPos.x, sheepPos.y, true)) {
					
					// pürfe, ob das Schaf gegen die Maschine gelaufen ist
					if(obstacle is Machine) {
						this.dispatchEvent(new SheepEvent(SheepEvent.SHEEP_REMOVED,this, index));
					}else if (obstacle is MoleHole){
						this.dispatchEvent(new SheepEvent(SheepEvent.SHEEP_LOST, this, index));
					}else {
						//  berechne eine neue Position, die einen Schritt vor dem Hinderniss liegt
						var newPosition:Point = new Point(sheepPos.x - this.speedX, sheepPos.y - this.speedY);
						
						// falls das Schaf gegen etwas über oder unter ihm gelaufen ist invertiere auch die y bewegung
						if (obstacle.hitTestPoint(sheepPos.x-this.speedX, sheepPos.y+5, true) || obstacle.hitTestPoint(sheepPos.x-this.speedX, sheepPos.y-5, true)){
							this.speedY *= -1;
						}else {
							// invertiere die beweung auf der x-Achse
							this.speedX *= -1;
						}
						
						// berechne den neuen Winkel, in den sich das Schaf bewegt
						var newAngle:Number = calculateAngle(new Point(this.x+this.speedX, this.y+this.speedY))+1;
						
						// und setzte eine entpsrechende neue Bewegungsanimation
						setWalkCycle(newAngle+180);
						
						// setzte das Schaf auf die Position vor dem Hinderniss
						this.x = level.globalToLocal(newPosition).x;
						this.y = level.globalToLocal(newPosition).y;
					}
					break;
				}
			}
		}
		
		
		
		
		
	}
}