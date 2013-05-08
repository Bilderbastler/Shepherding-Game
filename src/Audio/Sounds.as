package Audio
{
	import flash.errors.IllegalOperationError;
	import flash.events.Event;
	import flash.media.Sound;
	import flash.utils.Timer;
	
	public  class Sounds
	{
		// der Timer wird verwendet, um zu verhindern, dass Sounds zu oft hinter einander abgespielt werden
		private var timer:Timer;
		// Zeitpunkt des letzten Schaf-Sounds
		private var lastSheepSound:int;
		// Zeitpunkt des letzten Hunde-Sounds
		private var lastDogSound:int;
		// Zeitpunkt des letzten Maschinen-Sounds
		private var lastMachineSound:int;
		// Der Scheer-Ton
		private var maschineSound:Sound;
		// die Umgebungsgeräusche
		private var natureSound:Sound;
		// ein Array mit Schaf-Tönen
		private var sheepSounds:Array;
		// ein Array mit Hune-Tönen
		private var dogSounds:Array;
		
		// die instanz der Klasse
		private static var instance:Sounds;
		
		public function Sounds()
		{
			// Fehler, wenn der Konstruktor aufgerufen wird, obwohl schon eine Instanz verfügbar ist.
			if(instance != null){
				throw new IllegalOperationError("Dies ist eine Singleton-Klasse! Der Aufruf des Kontruktors ist verboten");
			}else{
				// erzeuge neuen Timer
				timer = new Timer(1000);
				timer.start();
				
				// Zeiten auf 0 setzten
				lastSheepSound = 0;
				lastDogSound = 0;
				lastMachineSound = 0;
				
				// erzeuge sounds
				maschineSound = new rasierer();
				natureSound = new natur();
				
				// fülle das schaf-sounds array mit sounds
				sheepSounds = new Array();
				sheepSounds.push(new schaf1(), new schaf2(), new schaf3(), new schaf4());
				
				// fülle das hunde-sounds array mit sounds
				dogSounds = new Array();
				dogSounds.push(new hund1(), new hund2(), new hund3(), new hund4(), new hund5(), new hund6(), new hund7(),
					new hund8(), new hund9());
					
				// fülle die Instanz
				instance = this;
			}
			 
		}
		
		// liefert die Instanz der Singleton-Klasse
		public static function getInstance():Sounds{
			if(instance == null){
				return new Sounds();
			}else{
				return instance;
			}
		}
		
		public function Sheep():void{
			// wenn ein Schafsound länger her ist als drei Sekunden, spiele einen Sound ab
			if(timer.currentCount - lastSheepSound > 3){
				// spiele einen zufälligen Sound von den Schafsounds ab.
				(sheepSounds[int(Math.random()*sheepSounds.length)] as Sound).play()
				lastSheepSound = timer.currentCount;
			}
		}
		
		public function Dog():void{
			// wenn ein Hunde Sound länger her ist als drei Sekunden, spiele einen Sound ab
			if(timer.currentCount - lastDogSound > 3){
				// spiele einen zufälligen Sound von den Schafsounds ab.
				(dogSounds[int(Math.random()*dogSounds.length)] as Sound).play()
				lastDogSound = timer.currentCount;
			}
		}
		
		public function Maschine():void{
			// wenn es länger als eine Sekunde her ist, dass der Maschinen Sound zu hören war, spiele ihn ab
			if(timer.currentCount - lastMachineSound >= 1){
				maschineSound.play();
				lastMachineSound = timer.currentCount;
			}
		}
		
		public function Nature():void{
			// beginne die Athmo erneut zu spielen, wenn sie zu ende ist.
			natureSound.addEventListener(Event.COMPLETE, function(e:Event):void{
				natureSound.play();
			});
			natureSound.play();
		}
		

	}
}