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
		public static const ZOOM_IN:String='zoomIn';
		public static const ZOOM_OUT:String = 'zoomOut';
		
		public static const ZOOMING:String='zooming'
		public static const DRAGGING:String = 'dragging';
		public static const ROTATING:String = 'rotatitng';		
		
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