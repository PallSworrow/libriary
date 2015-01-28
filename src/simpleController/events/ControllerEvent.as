package simpleController.events 
{
	import flash.events.Event;
	import simpleController.Controller;
	import simpleController.interfaces.Igessture;
	/**
	 * ...
	 * @author 
	 */
	public class ControllerEvent extends Event
	{
		public static const GESSTURE_START:String = 'gessstart';
		public static const GESSTURE_UPDATE:String = 'gessupdate';
		public static const GESSTURE_COMPLETE:String = 'gesscomplete';
		public static const GESSTURER_ABORTED:String = 'gessaborted';
		//public static const SWIPE_LEFT:String = 'swipeleft';
		//public static const SWIPE_RIGHT:String = 'swiperight';
		//public static const SWIPE_UP:String = 'swipeleft';
		//public static const SWIPE_DOWN:String = 'swipedown';
		public static const SWIPE:String = 'swipe';
		public static const TAP:String = 'tap';
		//public static const PRESS:String = 'press';//== start
		//public static const RELEASE:String = 'release'; == complete
		//public static const RELEASE_ANYWHERE:String = 'releaseanywhere';
		
		private var _gessture:Igessture
		public function ControllerEvent(type:String, gess:Igessture) 
		{
			super(type);
			_gessture = gess;
		}
		
		public function get gessture():Igessture 
		{
			return _gessture;
		}
		public function get controller():Controller
		{
			return target as Controller;
		}
		
	}

}