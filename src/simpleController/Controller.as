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
	import simpleTools.getStage;
	/**
	 * ...
	 * @author 
	 */
	public class Controller extends EventDispatcher
	{
		private static var globalStage:Stage;
		
		private var _item:InteractiveObject
		private var _enable:Boolean = true;
		private var _inputMode:String = InputMode.MOUSE;
		private var _parameters:ControllerParams;
		public function Controller(item:InteractiveObject=null) 
		{
			gesstures = new Dictionary();
			_parameters = new ControllerParams();
			this.item = item;
			super(this);
		}
		//PUBLIC
		/**
		 * Объект события которого будут прослушиваться
		 */
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
		/**
		 * Включение/выключения отправки событий
		 */
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
		//Переключение режомов работы контроллера - InputMode.MOUSE | InputMode.TOUCH
		public function get inputMode():String 
		{
			return _inputMode;
		}
		
		public function set inputMode(value:String):void 
		{
			if ((value == InputMode.MOUSE || value == InputMode.TOUCH) && _inputMode != value);
			_inputMode = value;
			if (enable) //=> reset
			{
				stopListening();
				startListening();
			}
		}
		//список параметров работы контроллера
		public function get parameters():ControllerParams 
		{
			return _parameters;
		}
		
		public function set parameters(value:ControllerParams):void 
		{
			if (!value) value = new ControllerParams();
			_parameters = value;
			
		}
		/**
		 * Прервать все текущие жесты.
		 */
		public function abort():void
		{
			for each (var gess:Gess in gesstures) 
			{
				dispatchCE(ControllerEvent.GESSTURER_ABORTED, gess);
				killGesture(gess);
				delete gesstures[gess.id];
			}
			if (globalStage)
			{
				globalStage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
				globalStage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
				
				globalStage.removeEventListener(TouchEvent.TOUCH_MOVE, onTouchMove);
				globalStage.removeEventListener(TouchEvent.TOUCH_END, onTouchEnd);
			}
		}
		
		
		//METHODS:
		protected function startListening():void
		{
			trace(this, 'START LISTENING',inputMode);
			if (inputMode == InputMode.MOUSE)
				item.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown,false,0,true)
				
			else
				item.addEventListener(TouchEvent.TOUCH_BEGIN, onTouchStart,false,0,true);
		}
		
		protected function stopListening():void
		{
			abort();
			item.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown)
			item.removeEventListener(TouchEvent.TOUCH_BEGIN, onTouchStart);
		}
		
		
		
		
		private function dispatchCE(type:String, gess:Gess):void
		{
			dispatchEvent(new ControllerEvent(type, gess));
		}
		//ENGINE:
		private var gesstures:Dictionary;
		private var touchGessCount:int = 0;//mouse gess count always = 0/1)
		private function _onGestureStart(X:Number,Y:Number,id:String):void
		{
			trace('NEW GESS: ' + id);
			if (!globalStage)
			{
				globalStage = getStage(item);
			}
			var gess:Gess;
			if (id == 'mouse')
			{
				globalStage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove,false,0,true);
				globalStage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
				
				if (gesstures[id])
				throw new Error("previos " + id + " gess hasn's been complete");
			}
			else
			{
				if(touchGessCount <= 0)
				{
					globalStage.addEventListener(TouchEvent.TOUCH_MOVE, onTouchMove,false,0,true);
					globalStage.addEventListener(TouchEvent.TOUCH_END, onTouchEnd,false,0,true);
				}
				touchGessCount ++;
			}
			//else 
			//throw new Error('invalid gess start event: ' + e);
			
			
			gess = createGesture();
			gess.init(X, Y, id);
			gesstures[id] = gess;
			
			//dispatch:
			onGessStart(gess);
			dispatchCE(ControllerEvent.GESSTURE_START, gess);
			
			
			
		}
		protected function _onGestureUpdate(X:Number,Y:Number,id:String):void
		{
			var gess:Gess;
			var id:String;
			
			if (!gesstures[id]) 
			{
				if(id == 'mouse')
				throw new Error(id + " gessture hasn't been inited before update() call");
				else
				return;
			}
			
			gess = gesstures[id];
			gess.update(X, Y);
			
			//dispatch:
			onGessUpdate(gess);
			dispatchCE(ControllerEvent.GESSTURE_UPDATE, gess);
			
		
		}
		protected function _onGestureComplete(X:Number,Y:Number,id:String):void
		{
			if (!gesstures[id]) 
			{
				if(id == 'mouse')
				throw new Error(id + " gessture hasn't been inited before update() call");
				else
				return;
			}
			var gess:Gess;
			var id:String;
			var res:String;
			if (id == 'mouse')
			{
				globalStage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
				globalStage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			}
			else //if (e is TouchEvent)
			{
				touchGessCount --;
				if(touchGessCount <= 0)
				{
					globalStage.removeEventListener(TouchEvent.TOUCH_MOVE, onTouchMove);
					globalStage.removeEventListener(TouchEvent.TOUCH_END, onTouchEnd);
				}
			}
			//else throw new Error('invalid gess complete event: ' + e);
			
			
			gess = gesstures[id];
			res = gess.complete();
			
			if (res) dispatchCE(res, gess);//tap|swipe
			//dispatch:
			onGessComplete(gess);
			dispatchCE(ControllerEvent.GESSTURE_COMPLETE, gess);
			
			
			
			delete gesstures[id];
			killGesture(gess);
			
		}
		private var gessPool:Vector.<Gess> = new Vector.<Gess>;
		private function createGesture():Gess
		{
			if (gessPool.length > 0) return gessPool.shift();
			else return new Gess(_parameters);
		}
		private function killGesture(gess:Gess):void
		{
			
			gess.dispose();
			gessPool.push(gess);
		}
		protected function onGessStart(gess:Gess):void
		{
			
		}
		protected function onGessUpdate(gess:Gess):void
		{
			
		}
		protected function onGessComplete(gess:Gess):void
		{
			
		}
		//EVENTS:
		private function onMouseDown(e:MouseEvent):void {_onGestureStart(e.stageX, e.stageY, 'mouse'); }
		private function onMouseMove(e:MouseEvent):void { _onGestureUpdate(e.stageX, e.stageY, 'mouse'); }
		private function onMouseUp(e:MouseEvent):void 	{ _onGestureComplete(e.stageX, e.stageY, 'mouse'); }
		private function onTouchStart(e:TouchEvent):void {  _onGestureStart(e.stageX, e.stageY, 'touch' + e.touchPointID); }
		private function onTouchMove(e:TouchEvent):void { _onGestureUpdate(e.stageX, e.stageY, 'touch'+e.touchPointID); }
		private function onTouchEnd(e:TouchEvent):void  { _onGestureComplete(e.stageX, e.stageY, 'touch'+e.touchPointID); }
	}

}