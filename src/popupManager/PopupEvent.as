package popupManager 
{
	import flash.events.Event;
	/**
	 * ...
	 * @author 
	 */
	public class PopupEvent extends Event
	{
		public static const ADDED_TO_FLOW:String = 'addedTOFlow';
		public static const REMOVED_FROM_FLOW:String = 'removedFromFlow';
		
		public static const DISPLAY:String='display';
		//public static const DISPLAY_COMPLETE:String='displayComplete';
		
		public static const HIDE:String='hide';
		//public static const HIDE_COMPLETE:String='hideComplete';
		
		
		
		public function PopupEvent(type:String) 
		{
			super(type);
		}
		
	}

}