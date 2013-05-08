package Events
{
	import Characters.Sheep;
	
	import flash.events.Event;
	public class SheepEvent extends Event
	{
		public static const SHEEP_REMOVED:String = "SHEEP_REMOVED";
		public static const SHEEP_LOST:String = "SHEEP_LOST";
		public var sheep:Sheep;
		public var sheepIndex:int;
		public function SheepEvent(type:String, sheep:Sheep, sheepIndex:int, bubbles:Boolean=true, cancelable:Boolean=false){
			super(type, bubbles, cancelable);
			this.sheep = sheep;
			this.sheepIndex = sheepIndex;
		}
		
	}
}