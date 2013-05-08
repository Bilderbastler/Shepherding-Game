package Events
{
	
	import flash.events.Event;

	public class GameEvent extends Event
	{
		public static const END_GAME:String = "END_GAME";
		public static const NEW_POINTS:String = "NEW_POINTS";
		
		
		public var points:uint; 
		public function GameEvent(type:String, points:uint, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.points = points;
		}
		
	
		
	}
}