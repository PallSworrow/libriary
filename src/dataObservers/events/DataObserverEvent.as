package Swarrow.tools.dataObservers.events {
	import flash.events.Event;
	
	/**
	 * ...
	 * @author pall
	 */
	public class DataObserverEvent extends Event 
	{
		
		public function DataObserverEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, bubbles, cancelable);
			
		}
		
	}

}