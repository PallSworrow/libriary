package simpleButton.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author 
	 */
	public class BtnEvent extends Event 
	{
		public static const ACTIVATED:String = 'activated';
		public static const DEACTIVATED:String = 'deactivated';
		public static const PHAZE_CHANGED:String = 'phaze_chagnged';
		public static const TAP:String = 'tapped';
		public function BtnEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, bubbles, cancelable);
			
		}
		
	}

}