package dataObservers {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Rectangle;
	import flash.sampler.DeleteObjectSample;
	/**
	 * ...
	 * @author pall
	 */
	public class RectangleObserver extends EventDispatcher implements IdataObserver 
	{
		
		private var _xObserver:IntegerObserver;
		private var _yObserver:IntegerObserver;
		private var _wObserver:IntegerObserver;
		private var _hObserver:IntegerObserver;
		public function RectangleObserver(x:Object=0,y:Object=0,w:Object=0,h:Object=0) 
		{
			super();
			if (x is IntegerObserver) _xObserver = x as IntegerObserver;
			else _xObserver = new IntegerObserver(int(x));
			
			if (y is IntegerObserver) _xObserver = y as IntegerObserver;
			else _yObserver = new IntegerObserver(int(y));
			
			if (w is IntegerObserver) _xObserver = w as IntegerObserver;
			else _wObserver = new IntegerObserver(int(w));
			
			if (h is IntegerObserver) _xObserver = h as IntegerObserver;
			else _hObserver = new IntegerObserver(int(h));
			
			_xObserver.addEventListener(Event.CHANGE, update);
			_yObserver.addEventListener(Event.CHANGE, update);
			_wObserver.addEventListener(Event.CHANGE, update);
			_hObserver.addEventListener(Event.CHANGE, update);
		}
		
		public function get x():int 	{ return _xObserver.currentValue; }
		public function get y():int 	{ return _yObserver.currentValue; }
		public function get width():int { return _wObserver.currentValue; }
		public function get height():int{ return _hObserver.currentValue; }
		
		public function set x(value:int):void	  { _xObserver.currentValue = value;  }
		public function set y(value:int):void	  { _yObserver.currentValue = value;  }
		public function set width(value:int):void { _wObserver.currentValue = value;  }
		public function set height(value:int):void{ _hObserver.currentValue = value; }
		
		public function get currentValue():Rectangle
		{
			return new Rectangle(x, y, width, height);
		}
		public function set currentValue(value:Rectangle):void
		{
			
			_xObserver.removeEventListener(Event.CHANGE, update);
			_yObserver.removeEventListener(Event.CHANGE, update);
			_wObserver.removeEventListener(Event.CHANGE, update);
			_hObserver.removeEventListener(Event.CHANGE, update);
			
			_xObserver.currentValue = value.x;
			_xObserver.currentValue = value.y;
			_wObserver.currentValue = value.width;
			_hObserver.currentValue = value.height;
			update();
			_xObserver.addEventListener(Event.CHANGE, update);
			_yObserver.addEventListener(Event.CHANGE, update);
			_wObserver.addEventListener(Event.CHANGE, update);
			_hObserver.addEventListener(Event.CHANGE, update);
		}
		
		public function get xObserver():IntegerObserver 
		{
			return _xObserver;
		}
		public function get yObserver():IntegerObserver 
		{
			return _yObserver;
		}
		public function get wObserver():IntegerObserver 
		{
			return _wObserver;
		}
		public function get hObserver():IntegerObserver 
		{
			return _hObserver;
		}
		
		///////////iterface implementation:
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
		
		
	}

}