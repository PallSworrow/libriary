package dataObservers {
	import dataObservers.events.ArrayObserverEvent;
	import flash.events.Event;
	/**
	 * ...
	 * @author pall
	 */
	public class ArrayObserver extends DataObserver implements IdataObserver
	{
		private var _itemFilter:Function;
		private var _prevValue:Array;
		
		public var dispatchElementChanges:Boolean = false;
		public function ArrayObserver(value:Array=null, filter:Function=null) 
		{
			if (filter is Function) _itemFilter = filter;
			
			if (!value) value = [];
			super(value);
			updateSubListeners();
		}
		private function itemFilter(input:Object):Object
		{
			if (_itemFilter) return _itemFilter(input);
			return input;
		}
		/*override public function bindTo(getterFunc:Function, setterFunc:Function = null, observer:DataObserver = null):void 
		{
			throw new Error('Binding array observers is not supported for now');
		}*/
		protected function get _currentValue():Array
		{
			return currentData as Array;
		}
		protected function set _currentValue(value:Array):void
		{
			currentData = value;
		}
		private function dispatchAOE(type:String, added:Object = null, removed:Object = null):void
		{
			dispatchEvent(new ArrayObserverEvent(type, added, removed));
		}
		private function onElementUpdate(e:Event):void
		{
			if (dispatchElementChanges) update();
			
			dispatchAOE(ArrayObserverEvent.ELEMENT_CHANGE, [e.target]);
		}
		private function listenToItem(item:Object):void
		{
			if (item is IdataObserver) 
			{
				(item as IdataObserver).addListener(onElementUpdate);
			}
		}
		private function stopListeningItem(item:Object):void
		{
			if (item is IdataObserver) 
			{
				(item as IdataObserver).removeListener(onElementUpdate);
			}
		}
		private function updateSubListeners():void
		{
			var item:Object;
			for (var i:int = _currentValue.length - 1;i>=0; i--) 
			{
				listenToItem(_currentValue[i]);	
			}
		}
		private function removeSubListeners():void
		{
			var item:Object;
			for (var i:int = _currentValue.length - 1;i>=0; i--) 
			{
				stopListeningItem(_currentValue[i]);
			}
		}
		public function getItem(index:int):Object
		{
			return _currentValue[index];
		}
		public function get currentValue():Array
		{
			return _currentValue.slice();//returns a clone
		}
		public function set currentValue(value:Array):void 
		{
			if (_itemFilter)
			{
				for (var i:int = 0; i < value.length; i++) 
				{
					value[i] = itemFilter[i];
					listenToItem(value[i]);
				}
			}
			removeSubListeners();
			_prevValue = _currentValue;
			_currentValue = value;
			//update();
			dispatchAOE(ArrayObserverEvent.UPDATE,_currentValue,_prevValue);
			updateSubListeners();
		}
		public function setItem(value:Object, index:int):void
		{
			_prevValue = currentValue;
			var prevItem:Object = _currentValue[index];
			_currentValue[index] = value;
			dispatchAOE(ArrayObserverEvent.UPDATE,[value],[prevItem]);
			
		}
		public function push(item:Object):void
		{
			//trace(this, 'push:', item);
			item = itemFilter(item);
			_prevValue = currentValue;
			_currentValue.push(item);
			update();
			dispatchAOE(ArrayObserverEvent.UPDATE,[item]);
			listenToItem(item);
		}
		public function unshift(item:Object):void
		{
			item = itemFilter(item);
			_prevValue = currentValue;
			_currentValue.unshift(item);
			update();
			dispatchAOE(ArrayObserverEvent.UPDATE,[item]);
			listenToItem(item);
		}
		public function pop():Object
		{
			_prevValue = currentValue;
			var res:Object = _currentValue.pop();
			update();
			dispatchAOE(ArrayObserverEvent.UPDATE,null,[res]);
			stopListeningItem(res);
			return res;
		}
		public function shift():Object
		{
			_prevValue = currentValue;
			var res:Object = _currentValue.shift();
			update();
			dispatchAOE(ArrayObserverEvent.UPDATE,null,[res]);
			stopListeningItem(res);
			return res;
		}
		public function get length():int
		{
			return _currentValue.length;
		}
		
		public function get prevValue():Array 
		{
			return _prevValue.slice();
		}
		
		
		
		public function splice(from:int, length:int=1, insert:Array=null):void
		{
			_prevValue = currentValue;
			if (length < 0) length = this.length;
			for (var i:int = 0; i < length;i++ ) 
			{
				stopListeningItem(_currentValue[i+from]);
			}
			if (insert)
			{
				var item:Object;
				for (var j:int = 0; j < insert.length; j++) 
				{
					item = insert[j];
					insert[j] = itemFilter(item);
					listenToItem(item);
				}
			}
			//trace('SPLICE: ' + from, length);
			var removes:Array = _currentValue.splice(from, length);
			update();
			dispatchAOE(ArrayObserverEvent.UPDATE, [insert],[removes]);
			
		}
		
		
	}

}