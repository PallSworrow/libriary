package antares 
{
	import flash.display.NativeWindowDisplayState;
	import flash.display.Stage;
	import flash.display.StageDisplayState;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.NativeWindowDisplayStateEvent;
	import flash.events.TouchEvent;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	/**
	 * ...
	 * @author 
	 */
	public class BasicFunctional 
	{
		//hot keys:
		private static var keys:Array = [
		{code:Keyboard.F, handler:changeDisplayState },
		{code:Keyboard.T, handler:'mouse switch' },
		{code:Keyboard.L, handler:'console show/hide' }
		];
		
		private static var _stage:Stage
		// ---------------------------------- MAIN ----------------------------------
		/**
		 * 
		 * @param	stage
		 * @param	collapseParams: {multitouch:true|false, corners:'leftTop'|'rightTop'| 'leftBottom'|'rightBotton' (в случае с multitouch == true противоположные - равны по смыслу), maxDuration:miliseconds - время на выполнение жеста(1500 по-умолчанию)}
		 * @param	fullScreen
		 */
		public static function init(stage:Stage, collapseParams:Object, fullScreen:Boolean = true ):void
		{
			_stage = stage;
			if (collapseParams)
			{
				if (collapseParams.maxDuration) gessTimeLimit = collapseParams.maxDuration;
				if (collapseParams.multitouch)
				{
				}
				else
				{
					switch(collapseParams)
					{
						case 'rightTop':
							corner = new Point(stage.stageWidth, 0);
							break;
						case 'leftBottopm':
							corner = new Point(0,stage.stageHeight);
							break;
						case 'rightBottom':
							corner = new Point(stage.stageWidth,stage.stageHeight);
							break;
						case 'leftTop':
						default:
							corner = new Point(0, 0);
							break;
					}
					stage.addEventListener(MouseEvent.CLICK, collapse1);
					//stage.addEventListener(TouchEvent.TOUCH_TAP, collapse1);
				}
			}
			//init keys:
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onStageKeyDown);
			
			if(fullScreen)
			{
				stage.nativeWindow.addEventListener(NativeWindowDisplayStateEvent.DISPLAY_STATE_CHANGE, onDisplayStateChange);
				setScreenState(StageDisplayState.FULL_SCREEN_INTERACTIVE);
			}
		}
		//hot keys:
		static private function onStageKeyDown(e:KeyboardEvent):void 
		{
			for each (var hotkey:Object in keys) 
			{
				if (hotkey.code == e.keyCode && hotkey.handler is Function)
				{
					hotkey.handler();
				}
			}
		}
		//screen size:
		static private function onDisplayStateChange(event:NativeWindowDisplayStateEvent):void
        {
           if (event.afterDisplayState == NativeWindowDisplayState.MAXIMIZED) setScreenState(StageDisplayState.FULL_SCREEN_INTERACTIVE);
        }
		static private function changeDisplayState():void 
		{
			if (_stage.displayState == StageDisplayState.FULL_SCREEN_INTERACTIVE) 
				setScreenState(StageDisplayState.NORMAL);
            else 
				setScreenState(StageDisplayState.FULL_SCREEN_INTERACTIVE);
		}
		private static function setScreenState(state:String):void
		{
			_stage.displayState = state;
		}
		//////////////////////////////////////////////////////////////////////////////////////////////
		
		//collapse window:
		private static var lastCornerTap:Date;
		private static var corner:Point;
		private static var corner2:Point;//multitouch
		private static var gessTimeLimit:int = 1500;
		private static var reqAccurancy:int = 100;
		private static function collapse1(e:Object)//touch/mouse
		{
			
			var dis:int = Point.distance(new Point(e.stageX, e.stageY), corner);
			if (dis > reqAccurancy)
			{
				lastCornerTap = null;
				return;
			}
			var date:Date = new Date();
			if (lastCornerTap)
			{
				if (date.getTime() - lastCornerTap.getTime() < gessTimeLimit)
				{
					lastCornerTap = null;
					setScreenState(StageDisplayState.NORMAL);
					return;
				}
			}
			
			lastCornerTap = date;
		}
		
		
		
		//downtime:
		private static var downTimer:uint;
		private static var dtDuration:int;
		private static var dtHandler:Function;
		private static const prolongingEvents:Array = [MouseEvent.MOUSE_DOWN/*,MouseEvent.MOUSE_MOVE*/,KeyboardEvent.KEY_DOWN, TouchEvent.TOUCH_BEGIN/*,TouchEvent.TOUCH_MOVE*/];
		public static function initDownTime(handler:Function, time:int):void
		{
			dtHandler = handler;
			dtDuration = time;
			startDowntimer();
		}
		public static function startDowntimer():void
		{
			//add listeners;
			for (var i:int = 0; i < prolongingEvents.length; i++) 
			{
				_stage.addEventListener(prolongingEvents[i], prolong);
			}
			prolong();
		}
		public static function prolong(e:Event = null):void
		{
			clearTimeout(downTimer);
			downTimer = setTimeout(onDowntime, dtDuration);
		}
		private static function onDowntime():void
		{
			dtHandler();
			stopDownTime();
		}
		public static function stopDownTime():void
		{
			//remove listeners;
			for (var i:int = 0; i < prolongingEvents.length; i++) 
			{
				_stage.removeEventListener(prolongingEvents[i], prolong);
			}
			clearTimeout(downTimer);
		}
	}

}