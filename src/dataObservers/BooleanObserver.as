package dataObservers {
	import flash.events.EventDispatcher;
	import Swarrow.tools.dataObservers.BooleanObserver;
	/**
	 * ...
	 * @author pall
	 */
	public class BooleanObserver extends DataObserver implements IdataObserver
	{
		
		private var _prevValue:Boolean;
		public function BooleanObserver(value:Boolean) 
		{
			super(value);
		}
		public function get currentValue():Boolean 
		{
			return Boolean(currentData);
		}	
		public function set currentValue(value:Boolean):void 
		{
			_prevValue = currentValue;
			currentData = value;
		}
		
	}

}