package layouts.glifs 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author 
	 */
	public class GlifEvent extends Event 
	{
		public static const WIDTH_CHANGE:String = 'width_change';
		public static const HEIGHT_CHANGE:String = 'height_change';
		public static const SIZE_CHANGE:String = 'size_change';
		
		public static function validate(value:String):Boolean
		{
			if (value == WIDTH_CHANGE || value == HEIGHT_CHANGE || value == SIZE_CHANGE)
			return true;
			else 
			return false;
		}
		//public static const DATA_CHANGE:String = 'data_change';
		//public static const STYLE_CHANGE:String = 'style_change';
		//public static const MOVE:String = 'move';
		public function GlifEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, bubbles, cancelable);
			
		}
		
	}

}