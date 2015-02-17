package _examples 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import simpleController.Controller;
	import simpleController.events.ControllerEvent;
	
	/**
	 * ...
	 * @author 
	 */
	public class ControllerExample extends Sprite 
	{
		private var controller:Controller
		private var trigger:Sprite;
		private var tf:TextField;
		public function ControllerExample() 
		{
			super();
			//создаем тестовый объект
			trigger = new Sprite();
			trigger.graphics.beginFill(0x999999);
			trigger.graphics.drawRect(0, 0,200,200);
			trigger.graphics.endFill();
			trigger.cacheAsBitmap = true;
			trigger.x = trigger.y = 100;
			tf = new TextField();
			tf.width = 200;
			tf.selectable = false;
			trigger.addChild(tf);
			addChild(trigger);
			
			//создаем контроллер и привязывем к нему объект
			controller = new Controller(trigger);
			//или так:
			//controller.item = trigger;
			
			//вешаем слушатели:
			controller.addEventListener(ControllerEvent.GESSTURE_COMPLETE, onControllerEvent);
			controller.addEventListener(ControllerEvent.TAP,onTap)
			controller.addEventListener(ControllerEvent.SWIPE, onSwipe)
			controller.addEventListener(ControllerEvent.GESSTURE_UPDATE, onMove);
			//так можно включать и выключать контроллер:
			//controller.enable = false;
		}
		
		private function onMove(e:ControllerEvent):void 
		{
			//DRAGGING:
			trigger.x += e.gessture.lastStepX;
			trigger.y +=e.gessture.lastStepY;
		}
	
		private function onControllerEvent(e:ControllerEvent):void
		{
			trace('--- controller event  -----')
			trace('type:',e.type);
			trace('gessture distance:',e.gessture.distance);
			trace('gessture distanceX:',e.gessture.distanceX);
			trace('gessture distanceY:',e.gessture.distanceY);
			trace('gessture length:',e.gessture.trackLength);
			trace('gessture duration:',e.gessture.duration);
			trace('gessture direction:',e.gessture.vectorDirection);
			trace('======================= \n');
			if(e.gessture.isSwipeFailed && e.gessture.isTapFailed)
			tf.text  = '';
		}
		private function onTap(e:ControllerEvent):void
		{
			tf.text = 'TAP';
		}
		private function onSwipe(e:ControllerEvent):void
		{
			tf.text = 'SWIPE: ' + e.gessture.vectorDirection;
		}
	}

}