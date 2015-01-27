package requestFlow.constants 
{
	import flash.events.Event;
	import mx.events.Request;
	
	/**
	 * ...
	 * @author 
	 */
	public class FlowEvent extends Event 
	{
		public static const COMPLETE:String = 'complete';
		public static const NEW_REQ:String = 'newReq';
		public static const REQ_COMPLETE:String = 'reqComplete';
		
		public function FlowEvent(type:String, req:Request) 
		{
			super(type, bubbles, cancelable);
			
		}
		
	}

}