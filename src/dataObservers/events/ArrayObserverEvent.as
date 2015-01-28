package dataObservers.events 
{
	import flash.events.Event;
	import Swarrow.tools.dataObservers.ArrayObserver;
	
	/**
	 * ...
	 * @author pall
	 */
	public class ArrayObserverEvent extends Event 
	{
		//public static const SET:String = 'set';
		public static const UPDATE:String = 'update';
		public static const ELEMENT_CHANGE:String = 'elementChange';
		
		
		private var _newElenents:Array;
		private var _currenElements:Array;
		private var _removedElements:Array;
		public function ArrayObserverEvent(type:String, newElements:Array=null,removed:Array=null ) 
		{
			super(type);
			var prop:Object;
			_newElenents = newElements;
			_removedElements = removed;
			
		}
		public function get currentElements():Array
		{
			return (target as ArrayObserver).currentValue;
		}
		public function get removedElements():Array 
		{
			return _removedElements;
		}
		
		public function get newElenents():Array 
		{
			return _newElenents;
		}
		
	}

}