package simpleController.events 
{
	import adobe.utils.CustomActions;
	import flash.events.Event;
	import flash.utils.Dictionary;
	import simpleController.Controller;
	import simpleController.interfaces.Igessture;
	import simpleController.interfaces.ImultiTouchGess;
	import simpleController.MultitouchController;
	
	/**
	 * ...
	 * @author 
	 */
	public class MultitouchEvent extends Event 
	{
		private var _gess:ImultiTouchGess;
		
		public static const GESTURE_START:String = 'mtStart';
		public static const GESTURE_COMPLETE:String = 'mtComplete';
		public static const GESTURE_UPDATE:String = 'mtMove';
		public static const SWIPE:String = 'mtSwipe';
		
		public function MultitouchEvent(type:String,gess:ImultiTouchGess) 
		{
			super(type);
			_gess = gess;
		}
		public function get gessture():ImultiTouchGess
		{
			return _gess;
		}
		public function get controller():MultitouchController
		{
			return target as MultitouchController;
		}
	}

}