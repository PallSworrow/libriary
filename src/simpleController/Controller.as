package simpleController 
{
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import simpleController.events.ControllerEvent;
	/**
	 * ...
	 * @author 
	 */
	public class Controller extends EventDispatcher
	{
		
		private var _item:InteractiveObject
		private var _enable:Boolean = true;
		private var _inputMode:String = InputMode.MOUSE;
		private var _parameters:ControllerParams;
		public function Controller(item:InteractiveObject=null) 
		{
			
			_parameters = new ControllerParams();
			this.item = item;
			super(this);
		}
		//PUBLIC
		public function get item():InteractiveObject 
		{
			return _item;
		}
		public function set item(value:InteractiveObject):void 
		{
			if (_item && enable) stopListening();
			_item = value;
			if (_item && enable) startListening();
		}
		public function get enable():Boolean 
		{
			return _enable;
		}
		public function set enable(value:Boolean):void 
		{
			if (_enable == value) return;
			_enable = value;
			if (_item)
			{
				if(value)
				startListening();
				else
				stopListening();
			}
		}
		
		public function get inputMode():String 
		{
			return _inputMode;
		}
		
		public function set inputMode(value:String):void 
		{
			if ((value == InputMode.MOUSE || value == InputMode.TOUCH) && _inputMode != value);
			_inputMode = value;
			if (enable) 
			{
				
			}
		}
		
		public function get parameters():ControllerParams 
		{
			return _parameters;
		}
		
		public function set parameters(value:ControllerParams):void 
		{
			if (!value) value = new ControllerParams();
			_parameters = value;
			
		}
		public function abort():void
		{
			if (gesstures)
			{
				for each (var gess:Gess in gesstures) 
				{
					dispatchCE(ControllerEvent.GESSTURER_ABORTED, gess);
				}
				gesstures = new Dictionary;
				item.stage.removeEventListener(MouseEvent.MOUSE_MOVE, onGesstureUpdate);
				item.stage.removeEventListener(MouseEvent.MOUSE_UP, onGesstureComplete);
				item.stage.removeEventListener(TouchEvent.TOUCH_MOVE, onGesstureUpdate);
				item.stage.removeEventListener(TouchEvent.TOUCH_END, onGesstureComplete);
			}
			//removelisteners
			//dispatch aborts
		}
		
		
		//METHODS:
		protected function startListening():void
		{
			//trace(this, 'START LISTENING');
			gesstures = new Dictionary();
			if (inputMode == InputMode.MOUSE)
				item.addEventListener(MouseEvent.MOUSE_DOWN, onGesstureStart)
				
			else
				item.addEventListener(TouchEvent.TOUCH_BEGIN, onGesstureStart);
		}
		
		protected function stopListening():void
		{
			gesstures = null;
			item.removeEventListener(MouseEvent.MOUSE_DOWN, onGesstureStart)
			item.removeEventListener(TouchEvent.TOUCH_BEGIN, onGesstureStart);
			
			item.stage.removeEventListener(MouseEvent.MOUSE_MOVE, onGesstureUpdate);
			item.stage.removeEventListener(MouseEvent.MOUSE_UP, onGesstureComplete);
			
			item.stage.removeEventListener(TouchEvent.TOUCH_MOVE, onGesstureUpdate);
			item.stage.removeEventListener(TouchEvent.TOUCH_END, onGesstureComplete);
		}
		
		
		
		
		private function dispatchCE(type:String, gess:Gess):void
		{
			dispatchEvent(new ControllerEvent(type, gess));
		}
		//ENGINE:
		private var gesstures:Dictionary;
		private var touchGessCount:int = 0;//mouse gess count always = 0/1)
		protected function onGesstureStart(e:Object):Gess
		{
			var gess:Gess;
			var id:String;
			var X:int = e.stageX;
			var Y:int = e.stageY;
			if (e is MouseEvent)
			{
				id = 'mouse';
				item.stage.addEventListener(MouseEvent.MOUSE_MOVE, onGesstureUpdate);
				item.stage.addEventListener(MouseEvent.MOUSE_UP, onGesstureComplete);
			}
			else if (e is TouchEvent)
			{
				id = 'touch' + e.touchPointID;
				if(touchGessCount <= 0)
				{
					item.stage.addEventListener(TouchEvent.TOUCH_MOVE, onGesstureUpdate);
					item.stage.addEventListener(TouchEvent.TOUCH_END, onGesstureComplete);
				}
				touchGessCount ++;
			}
			else 
			throw new Error('invalid gess start event: ' + e);
			
			if (gesstures[id])
			throw new Error("previos " + id + " gess hasn's been complete");
			
			gess = new Gess(X, Y, id,parameters);
			gesstures[id] = gess;
			
			//dispatch:
			dispatchCE(ControllerEvent.GESSTURE_START, gess);
			
			
			return gess;
			
		}
		protected function onGesstureUpdate(e:Object):Gess
		{
			var gess:Gess;
			var id:String;
			var X:int = e.stageX;
			var Y:int = e.stageY;
			if (e is MouseEvent)
			id = 'mouse';
			else if (e is TouchEvent)
			id = 'touch' + e.touchPointID;
			else throw new Error('invalid gess update event: ' + e);
			
			if (!gesstures[id]) 
			throw new Error(id+" gessture hasn't been inited before update() call");
			gess = gesstures[id];
			gess.update(X, Y);
			
			//dispatch:
			dispatchCE(ControllerEvent.GESSTURE_UPDATE, gess);
			
			return gess;
		
		}
		protected function onGesstureComplete(e:Object):Gess
		{
			var gess:Gess;
			var id:String;
			var X:int = e.stageX;
			var Y:int = e.stageY;
			var res:String;
			if (e is MouseEvent)
			{
				id = 'mouse';
				item.stage.removeEventListener(MouseEvent.MOUSE_MOVE, onGesstureUpdate);
				item.stage.removeEventListener(MouseEvent.MOUSE_UP, onGesstureComplete);
			}
			else if (e is TouchEvent)
			{
				id = 'touch' + e.touchPointID;
				touchGessCount --;
				if(touchGessCount <= 0)
				{
					item.stage.removeEventListener(TouchEvent.TOUCH_MOVE, onGesstureUpdate);
					item.stage.removeEventListener(TouchEvent.TOUCH_END, onGesstureComplete);
				}
			}
			else throw new Error('invalid gess complete event: ' + e);
			
			if (!gesstures[id]) 
			throw new Error(id+" gessture hasn't been inited before complete() call");
			
			gess = gesstures[id];
			res = gess.complete();
			
			delete(gesstures[id]);
			
			if (res) dispatchCE(res, gess);//tap|swipe
			//dispatch:
			dispatchCE(ControllerEvent.GESSTURE_COMPLETE, gess);
			
			return gess;
		}
		
	}

}