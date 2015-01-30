package scrollers.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author 
	 */
	public class ScrollerEvent extends Event 
	{
		public static const SCROLL:String = 'scroll';
		public static const SCROLL_START:String = 'scrollstart';
		public static const SCROLL_COMPLETE:String = 'scrollcomplete';
		private var _from:Number;
		private var _to:Number;
		public function ScrollerEvent(type:String, from:Number, to:Number) 
		{
			_from = from;
			_to = to;
			super(type);
			
		}
		
		public function get from():Number 
		{
			return _from;
		}
		
		public function get to():Number 
		{
			return _to;
		}
		
	}

}