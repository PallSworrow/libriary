package simpleController 
{
	import flash.display.InteractiveObject;
	import flash.display.Shape;
	import flash.events.Event;
	import simpleController.events.ControllerEvent;
	import simpleController.events.MultitouchEvent;
	
	/**
	 * ...
	 * @author 
	 */
	public class MultitouchController extends Controller 
	{
		private var iterator:Shape;
		public function MultitouchController(item:InteractiveObject) 
		{
			super(item);
			iterator = new Shape();
		}
		override public function abort():void 
		{
			super.abort();
			gesture.dispose();
			iterator.removeEventListener(Event.ENTER_FRAME, iterator_enterFrame);
		}
		override protected function stopListening():void 
		{
			super.stopListening();
			gesture.dispose();
			iterator.removeEventListener(Event.ENTER_FRAME, iterator_enterFrame);
		}
		private var testGess:Gess;
		private var gesture:MultiGess;
		override protected function onGessStart(gess:Gess):void 
		{
			if (!gesture) gesture = new MultiGess(parameters);
			
			gesture.addGess(gess);
			
			if (gesture.numTouches == 1) 
			{
				gesture.init();
				dispatchME(MultitouchEvent.GESTURE_START);
			}
			testGess = new Gess(parameters);
			testGess.init(0, 0, 'test');
			gesture.addGess(testGess);
			iterator.addEventListener(Event.ENTER_FRAME, iterator_enterFrame,false,0,true);
			
		}
		private function iterator_enterFrame(e:Event):void 
		{
			if (gesture.numTouches == 0) return;
			gesture.update();
			if(gesture.lastStepX !=0 || gesture.lastStepY !=0)
			dispatchME(MultitouchEvent.GESTURE_MOVE);
			
			if (gesture.scaleStep != 0)
			dispatchME(MultitouchEvent.GESTURE_ZOOM);
			
		}
		override protected function onGessComplete(gess:Gess):void 
		{
			gesture.removeGess(gess);
			gesture.removeGess(testGess);
			var res:String;
			if (gesture.numTouches == 0)
			{
				//completeres = gess.complete();
				res = gess.complete()
				if (res == ControllerEvent.SWIPE)
				dispatchME(MultitouchEvent.SWIPE);
				
				dispatchME(MultitouchEvent.GESTURE_COMPLETE);
				
				iterator.removeEventListener(Event.ENTER_FRAME, iterator_enterFrame);
				gesture.dispose();
			}
		}
		
		/*override protected function onGesstureStart(e:Object):Gess 
		{
			var gess:Gess = super.onGesstureStart(e);
			
			if (!gessture) 
			{
				gessture = new MultiGess(gess, 'multitouch', parameters);
				iterator.addEventListener(Event.ENTER_FRAME, iterator_enterFrame);
			}
			else gessture.addGess(gess);
			
			return gess;
		}
		private function iterator_enterFrame(e:Event):void 
		{
			if (!gessture) return;
			gessture.update();
			
			dispatchME(MultitouchEvent.DRAGGING, gessture);
		}
		override protected function onGesstureComplete(e:Object):Gess 
		{
			var gess:Gess = super.onGesstureComplete(e);
			if (gessture)
			{
				gessture.removeGess(gess);
				if (gessture.numTouches == 0)
				{
					iterator.removeEventListener(Event.ENTER_FRAME, iterator_enterFrame);
					gessture.complete();
					gessture = null;
				}
			}
			return gess;
		}*/
		private function dispatchME(type:String):void
		{
			dispatchEvent(new MultitouchEvent(type, gesture));
		}
	}

}