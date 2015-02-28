package _examples 
{
	import com.greensock.TweenMax;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import simpleController.Controller;
	import simpleController.events.ControllerEvent;
	import simpleController.events.MultitouchEvent;
	import simpleController.InputMode;
	import simpleController.MultitouchController;
	import simpleTools.rotateAroundPoint;
	import simpleTools.scaleAroundPoint;
	
	/**
	 * ...
	 * @author 
	 */
	public class ControllerExample extends Sprite 
	{
		private var controller:MultitouchController
		private var trigger:Sprite;
		private var tf:TextField;
		private var gessCenter:Shape;
		public function ControllerExample() 
		{
			super();
			gessCenter = new Shape();
			gessCenter.graphics.beginFill(0xff0000);
			gessCenter.graphics.drawCircle(0, 0, 5);
			gessCenter.graphics.endFill();
			gessCenter.visible = false;
			
			//создаем тестовый объект
			trigger = new Sprite();
			trigger.graphics.beginFill(0x999999);
			trigger.graphics.drawRect(-100, -100,200,200);
			trigger.graphics.endFill();
			trigger.cacheAsBitmap = true;
			trigger.x = trigger.y = 100;
			tf = new TextField();
			tf.width = 200;
			tf.selectable = false;
			trigger.addChild(tf);
			addChild(trigger);
			addChild(gessCenter);
			
			//создаем контроллер и привязывем к нему объект
			controller = new MultitouchController(trigger);
			//или так:
			//controller.item = trigger;
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			controller.inputMode = InputMode.TOUCH;
			//вешаем слушатели:
			/*
			controller.addEventListener(ControllerEvent.GESSTURE_COMPLETE, onControllerEvent);
			controller.addEventListener(ControllerEvent.TAP,onTap)
			controller.addEventListener(ControllerEvent.SWIPE, onSwipe)
			controller.addEventListener(ControllerEvent.GESSTURE_UPDATE, onMove);*/
			//так можно включать и выключать контроллер:
			//controller.enable = false;
			controller.addEventListener(ControllerEvent.GESSTURE_START, onControllerEvent);
			
			controller.addEventListener(MultitouchEvent.GESTURE_START, onStart);
			controller.addEventListener(MultitouchEvent.GESTURE_UPDATE, onMove);
			controller.addEventListener(MultitouchEvent.GESTURE_COMPLETE, onComplete);
			controller.startDrag(true, true);
		}
		
		private function onComplete(e:MultitouchEvent):void 
		{
			gessCenter.visible = false;
		}
		private var Tscale:Number;
		private function onStart(e:MultitouchEvent):void 
		{
			gessCenter.visible = true;
			gessCenter.x = e.gessture.x;
			gessCenter.y = e.gessture.y;
			
			//ZOOMING:
			Tscale = trigger.scaleX;
		}
		
	
		private function onMove(e:MultitouchEvent):void 
		{
			gessCenter.x = e.gessture.x;
			gessCenter.y = e.gessture.y;
			
			//DRAGG & ROTATE:
		/*	trigger.x += e.gessture.lastStepX;
			trigger.y += e.gessture.lastStepY;
			var pt:Point = trigger.globalToLocal(new Point( e.gessture.x,  e.gessture.y));
			trigger.scaleX *= e.gessture.scaleStep; 
			trigger.scaleY *= e.gessture.scaleStep;
			trigger.rotation += e.gessture.rotationStep;
			pt = trigger.localToGlobal(pt);
			trigger.x = trigger.x+( e.gessture.x-pt.x);
			trigger.y = trigger.y+( e.gessture.y-pt.y);
			*/
			//rotateAroundPoint(trigger,e.gessture.rotationStep,new Point(e.gessture.x,e.gessture.y));
		}
	
		private function onControllerEvent(e:ControllerEvent):void
		{
			trace('--- controller event  -----')
			trace('type:', e.type);
			trace('gessture id:',e.gessture.id);
			trace('gessture distance:',e.gessture.distance);
			trace('gessture distanceX:',e.gessture.distanceX);
			trace('gessture distanceY:',e.gessture.distanceY);
			trace('gessture length:',e.gessture.trackLength);
			trace('gessture duration:',e.gessture.duration);
			trace('gessture direction:',e.gessture.vectorDirection);
			trace('======================= \n');
			if(e.gessture.isSwipeFailed && e.gessture.isTapFailed)
			tf.text  = '';
			gessCenter.x = (controller as MultitouchController).currentGesture.x;
			gessCenter.y = (controller as MultitouchController).currentGesture.y;
			
			trigger.x += e.gessture.lastStepX;
			trigger.y += e.gessture.lastStepY;
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