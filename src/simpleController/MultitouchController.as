package simpleController 
{
	import flash.display.InteractiveObject;
	import flash.display.Shape;
	import flash.events.Event;
	import simpleController.events.ControllerEvent;
	import simpleController.events.MultitouchEvent;
	import simpleController.interfaces.ImultiTouchGess;
	
	/**
	 * ...
	 * @author 
	 */
	public class MultitouchController extends Controller 
	{
		private static var iterator:Shape;
		public function MultitouchController(item:InteractiveObject) 
		{
			super(item);
			gesture = new MultiGess(parameters);
			if(!iterator) iterator = new Shape();
		}
		public function get currentGesture():ImultiTouchGess
		{
			if (gesture.state == 'disposed') return null;
			else return gesture;
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
			
			gesture.addGess(gess);
			
			if (gesture.numTouches == 1) 
			{
				gesture.init();
				dispatchME(MultitouchEvent.GESTURE_START);
				iterator.addEventListener(Event.ENTER_FRAME, iterator_enterFrame,false,0,true);
			}
			//gesture.addGess(testGess);
			
		}
		private function iterator_enterFrame(e:Event):void 
		{
			if (gesture.numTouches == 0) return;
			gesture.update();
			if(gesture.lastStepX !=0 || gesture.lastStepY !=0)
			dispatchME(MultitouchEvent.GESTURE_MOVE);
			if (gesture.rotationStep != 0)
			dispatchME(MultitouchEvent.GESTURE_ROTATE);
			
			if (gesture.scaleStep != 1)
			dispatchME(MultitouchEvent.GESTURE_ZOOM);
			
		}
		override protected function onGessComplete(gess:Gess):void 
		{
			gesture.removeGess(gess);
			//gesture.removeGess(testGess);
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
		
		
		private function dispatchME(type:String):void
		{
			dispatchEvent(new MultitouchEvent(type, gesture));
		}
	}

}