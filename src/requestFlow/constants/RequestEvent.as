package requestFlow.constants 
{
	import flash.events.Event;
	import requestFlow.InnerRequest;
	
	/**
	 * ...
	 * @author 
	 */
	public class RequestEvent extends Event 
	{
		//public static const PLAY:String = 'start';
		//public static const PAUSE:String = 'pause';
		public static const ABORT:String = 'abort';
		public static const COMPLETE:String = 'complete';
		public static const ERROR:String = 'error';
		//public static const STATUS_CHAGE:String = 'STATUS_CHAGE';
		
		public function RequestEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, bubbles, cancelable);
			
		}
		public function get request():InnerRequest
		{
			return target as InnerRequest;
		}
	}

}