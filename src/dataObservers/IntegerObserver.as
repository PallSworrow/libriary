package dataObservers {
	import flash.events.Event;
	/**
	 * ...
	 * @author pall
	 */
	public class IntegerObserver extends DataObserver implements IdataObserver
	{
		private var _prevValue:int;
		public function IntegerObserver(value:int=0) 
		{
			super(value);
		}
		public function get currentValue():int 
		{
			return int(currentData);
		}
		
		public function set currentValue(value:int):void 
		{
			_prevValue = currentValue;
			currentData = value;
			
		}
		
		public function get prevValue():int 
		{
			return _prevValue;
		}
		
		public function inherit(observer:IntegerObserver, params:Object):void
		{
			if (!params) params = { };
			var getter:Function;
			var setter:Function;
			//defaults:
			var multiplier:Number = 1;
			var offset:int = 0;
			var feedBack:Boolean = false;
			//parameters:
			if (params.multiply is Number) multiplier = params.multiply;
			if (params.offset is Number) offset = params.offset;
			if (params.feedBack) feedBack = feedBack;
			//min
			//max
			//invert
			//
			getter = function():int
			{
				return observer.currentValue * multiplier + offset;
			}
			if (feedBack)
			{
				setter = function(value:int):void
				{
					observer.currentValue = (value-offset) / multiplier;
				}
			}
			
			bindTo(observer, getter, setter);
			
		}
		
	}

}