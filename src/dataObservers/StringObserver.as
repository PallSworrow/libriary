package dataObservers {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	/**
	 * ...
	 * @author pall
	 */
	public class StringObserver extends DataObserver implements IdataObserver
	{
		
		private var _prevValue:String;
		public function StringObserver(value:String ='') 
		{
			super(value);
		}
		public function get currentValue():String 
		{
			return String(currentData);
		}
		
		public function set currentValue(value:String):void 
		{
			_prevValue = currentValue;
			currentData = value;
		}
		
		public function get prevValue():String 
		{
			return _prevValue;
		}
		
		
		
	}

}