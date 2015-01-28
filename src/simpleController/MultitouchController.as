package simpleController 
{
	import flash.display.InteractiveObject;
	import flash.display.Shape;
	import flash.events.Event;
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
			gessture = null;
			iterator.removeEventListener(Event.ENTER_FRAME, iterator_enterFrame);
		}
		override protected function stopListening():void 
		{
			super.stopListening();
			gessture = null;
			iterator.removeEventListener(Event.ENTER_FRAME, iterator_enterFrame);
		}
		
		private var gessture:MultiGess;
		override protected function onGesstureStart(e:Object):Gess 
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
		}
		private function dispatchME(type:String, gess:MultiGess):void
		{
			dispatchEvent(new MultitouchEvent(type, gess));
		}
	}

}