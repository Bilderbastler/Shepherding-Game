package
Characters {
	import Audio.Sounds;
	
	import MapElements.Map;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class Animal extends MovieClip
	{
		
		// die animatonsphasen
		protected var moveNorth:MovieClip;
		protected var moveNorthEast:MovieClip;
		protected var moveEast:MovieClip;
		protected var moveSouthEast:MovieClip;
		protected var moveSouth:MovieClip;
		protected var moveSouthWest:MovieClip;
		protected var moveWest:MovieClip;
		protected var moveNorthWest:MovieClip;
		protected var idle:MovieClip;
		
		// das Symbol des Tieres auf der miniMap
		protected var icon:Sprite;
		
		// das Ziel des Tiers
		protected var target:Point;
		
		// die Geschwindigkeit des Tiers
		protected const speed:Number = 10;
		
		// die derzeitige Geschwindigkeit auf der X-Achse
		protected var speedX:Number;
		
		// die derzeigte Geschwindigkeit auf der Y-Achse
		protected var speedY:Number;
		
		// die Entfernung des Tiers zum Ziel
		protected var distanceToTarget:Number;
		
		// das Spielfeld
		protected var level:Map;
		
		// die Sound-Engine
		protected var sounds:Sounds;
		
		public function Animal()
		{
			super();
			
			this.level = Map(this.parent);
			
			this.distanceToTarget = 0;
			
			// sucht das Standard-Bild des Tiers im Movieclip, setzt es als Idle-Animation und macht es erstmal unsichtbar
			this.idle = MovieClip(this.getChildAt(0));
			
			// erzeugt das Icon des Tieres
			this.icon = new Sprite();
			
			// hole Instanz der Sound-Klasse
			this.sounds = Sounds.getInstance();
			
		}

		// hält das Tier an
		public function stopMoving():void {
			
			// setzt die distanz auf null
			distanceToTarget = 0;
			
			// entferne den Eventlistner			
			stage.removeEventListener(Event.ENTER_FRAME, moveAnimal);
			
			// bewegt das Tier ein kleines wenig zurück
			this.x -= speedX;
			this.y -= speedY;
			
			// setzt die Bewegungsanimation auf warten
			this.removeChildAt(0);
			this.addChild(idle);
			
			
		}
		
		//setzt die position des Icons auf die richtige Stelle nach dem Laden eines neuen Levels
		public function refreshIcon():void{
			this.icon.x = this.x;
			this.icon.y = this.y;
		}
		
		public function getPosition():Point{
			return new Point(this.x, this.y);
		}
		
		
		// setzt das Ziel des Tiers
		protected function setTarget(xPosition:int, yPosition:int):void {
			
			// das Ziel festlegen
			target = new Point(xPosition, yPosition);
			
			// relative distanz feststellen
			/*
			var dx:Number = target.x - this.x;
			var dy:Number = target.y - this.y;
			*/
			
			// die absolute Distanz bestimmen
			this.distanceToTarget = Point.distance(target, new Point(this.x, this.y));
			
			/*
			var angle:Number = Math.atan2(dy, dx);
			var degreeAngle:Number = 360 * (angle/(2 * Math.PI));
			*/
			startMovingAnimal();
	
		}
		
		// setzt Walkcycle, Bewegungsgschwindigkeit auf x und y Achse und den Eventlistener für die Beweung des Tieres
		protected function startMovingAnimal():void{
			
			// den Winkel vom Tier zum Ziel bestimmen und in Grad umrechnen
			var angle:Number = calculateAngle(target, false);
			var degreeAngle:Number = calculateAngle(target);
			
			// wähle die passende Bewegungsanimation aus
			setWalkCycle(degreeAngle+180);
			
			this.speedX = this.speed*Math.cos(angle);
			this.speedY = this.speed*Math.sin(angle);
			
			// bewege das Tier jeden Frame
			stage.addEventListener(Event.ENTER_FRAME, moveAnimal);
		}
		
		// bewegt das Tier Frame für Frame zum Ziel
		private function moveAnimal(event:Event):void {
			
			//wenn das Schaf sich nicht mehr auf auf der Karte befindet
		/*	if (this.x < 0 || this.y < 0 || this.y > stage.stageHeight || this.x > stage.stageWidth) {
				
				stopMoving();
				return;
			}
			*/
			// wenn das Tier sich noch nicht am Ziel befindet…
			if (this.distanceToTarget > 0) {
				
				// bewege das Tier auf der X und Y Achse um die berechnete Geschwindigkeit
				this.x += speedX;
				this.y += speedY;
				
				// und ziehe den zurückgelegten Weg von der Distanz ab
				this.distanceToTarget -= this.speed;
				
				// ändere die Position des Icons
				this.icon.x = this.x;
				this.icon.y = this.y;
				
			} else {
				
				// sonst entferne den Eventlistener und setze das Tier auf wartend
				stopAnimal();
				
			}
			
		}
		
		public function stopAnimal():void{
			this.removeChildAt(0);
			this.addChild(idle);
			stage.removeEventListener(Event.ENTER_FRAME, moveAnimal);
		}
		
		protected function setWalkCycle(angle:Number):void {
			
			// aktuelle Animation ausschalten:
			this.removeChildAt(0);
			
			// suche nach der Bewegungsanimation, die zum Winkel passt
			if (angle >= 337 || angle < 22) {
				this.addChild(moveWest);
			}else if (angle < 67) {
				this.addChild(moveNorthWest);
			}else if (angle < 112) {
				this.addChild(moveNorth);
			}else if (angle < 157) {
				this.addChild(moveNorthEast);
			}else if (angle < 202) {
				this.addChild(moveEast);
			}else if (angle < 247) {
				this.addChild(moveSouthEast);
			}else if (angle < 292) {
				this.addChild(moveSouth);
			}else if (angle < 337) {
				this.addChild(moveSouthWest);
			}
		}
		
		public  function calculateAngle(position:Point, degree:Boolean=true):Number {
			
			// dx und dy berechnen
			var deltaPosition:Point = position.subtract(getPosition());
			
			// den Winkel berechnen
			var angle:Number =  Math.atan2(deltaPosition.y, deltaPosition.x);
			
			// falls angabe in Grad gewünscht ist, wird umgerechnet
			if (degree) {
				return 360 * (angle/(2 * Math.PI));
			}else{
				return angle;
			}
		}
		
		public function checkCollision(object1 : MovieClip, object2 : MovieClip) : Boolean {
			var object1Rect : Rectangle = new Rectangle(object1.x - object1.width / 2, object1.y - object1.height / 2, object1.width, object1.height);
			var object2Rect : Rectangle = new Rectangle(object2.x - object2.width / 2, object2.y - object2.height / 2, object2.width, object2.height);
			
			return false;
		}
		
		// liefert das Icon des Tieres
		public function getIcon():Sprite{
			return this.icon;
		}
		
		// löscht das Icon des Tieres
		public function unsetIcon():void{
			this.icon = null;
			
		}
		
		// bereitet das Tier zum löschen vor
		public function destroyAnimal():void{
			this.moveNorth = null;
			this.moveEast = null;
			this.moveNorthEast = null;
			this.moveSouth = null;
			this.moveSouthEast = null;
			this.moveSouthWest = null;
			this.moveWest = null;
			this.idle = null;
			this.icon = null;
			this.target = null;
			this.level = null;
			this.sounds = null;
		}
	}
}