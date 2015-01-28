package dataObservers {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	/**
	 * ...
	 * @author pall
	 */
	public class DataObserver extends EventDispatcher implements IdataObserver
	{
		//binding:
		private var getter:Function;
		private var setter:Function;
		private var parentObservers:Vector.<DataObserver>;
		private var bindingCallBack:Boolean;
		private var binded:Boolean = false;
		
		//main:
		private var _currentData:Object;
		private var requiredType:Class;
		public function DataObserver(value:Object, typeValidator:Class=null) 
		{
			_currentData = value;
			requiredType = typeValidator;
			super(this);
		}
		public function bindTo(inheritFrom:Object,getterFunc:Function=null, setterFunc:Function=null, allowCallBack:Boolean=false):void
		{
			if (binded) 
			{
				unbind();
				return;
			}
			
			binded = true;
			switch(true)
			{
				case inheritFrom is DataObserver:
					parentObservers = Vector.<DataObserver>([inheritFrom as DataObserver]);
					(inheritFrom as DataObserver).addEventListener(Event.CHANGE, update);
					break;
				default:
					parentObservers = new Vector.<DataObserver>;
					for each(var dO:DataObserver in inheritFrom)
					{
						dO.addEventListener(Event.CHANGE, update);
						parentObservers.push(dO);
					}
					break;
			}
			if (parentObservers.length == 0 && (!getterFunc || !setterFunc)) 
			throw new Error('"inheritFrom" parameter must include at least one dataObserver or "getterFunc" and "setterFunc" function must be defined');
			if (getter)
			{
				if (getterFunc.length > 3)
				throw new Error('getterFunc can have 0-3 parameters');
			}
			if (setterFunc)
			{
				if (setterFunc.length > 2 || setterFunc.length<1)
				throw new Error('setterFunc can have 1-2 parameters');
			}
			
			
			bindingCallBack = allowCallBack;
			getter = getterFunc;
			setter = setterFunc;
			
			update();
		}
		public function unbind(loadOldValue:Boolean = false):void
		{
			if (!binded) return;
			
			binded = false;
			
			if(!loadOldValue)
			_currentData = currentData;
			
			for each(var dO:DataObserver in parentObservers)
			{
				dO.removeEventListener(Event.CHANGE, update);
			}
			parentObservers = null;
			getter = setter = null;
			
			update();
			
		}
		public function addListener(handler:Function):void
		{
			addEventListener(Event.CHANGE, handler);
		}
		public function removeListener(handler:Function):void
		{
			removeEventListener(Event.CHANGE,handler);
		}
		
		protected function update(e:Event = null)
		{
			dispatchEvent(new Event(Event.CHANGE));
			
		}
		
		protected function get currentData():Object 
		{
			var res:Object
			if (binded)
			{
				if (getter)
				{
					var arr:Array = [];
					for each (var dO:DataObserver in parentObservers) 
					{
						arr.push(dO.currentData);
					}
					switch(getter.length)
					{
						case 0:
							res = getter();
							break;
						case 1:
							
							res = getter(arr);
							break;
						case 2:
							res = getter(parentObservers, _currentData);
							break;
						default:
							throw new Error('invalid getter param number. No more than 3 is allowed');
							break;
						
					}
				}
				else
				res = parentObservers[0].currentData;
			}
			else
			res =  _currentData;
			
			/*if (requiredType && !(res is requiredType) && res)
			throw new Error('invalid type detected: ' + res + ', this observer can store only ' + requiredType);*/
			
			return res;
		}
		
		protected function set currentData(value:Object):void 
		{
			//check type
			
			if (binded)
			{
				if (setter)
				{
					switch(setter.length)
					{
						case 1:
							setter(value);
							break;
						case 2:
							setter(value, parentObservers);
							break;
						default:
							throw new Error('invalid setter params number. ');
							break;
					}
					if (parentObservers.length == 0)
					update();
				}
				else if(bindingCallBack)
				{
					parentObservers[0].currentData = value;
				}
				else
				{
					throw new Error("set value method doesn't allowed by current binding");
				}
			}
			else
			{
				_currentData = value;
				update();
			}
		}
		
		
		
	}

}