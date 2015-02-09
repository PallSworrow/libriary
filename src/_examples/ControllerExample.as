package _examples 
{
	import com.greensock.TweenMax;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import scrollers.events.ScrollerEvent;
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
			trigger = new Sprite();
			trigger.graphics.beginFill(0x999999);
			trigger.graphics.drawRect(0, 0,200,200);
			trigger.graphics.endFill();
			
			tf = new TextField();
			tf.width = 200;
			trigger.addChild(tf);
			addChild(trigger);
			
			controller = new Controller(trigger);
			//controller.addEventListener(ControllerEvent.GESSTURE_COMPLETE, onControllerEvent);
			controller.addEventListener(ControllerEvent.GESSTURE_UPDATE, onControllerEvent);
			controller.addEventListener(ControllerEvent.TAP,onTap)
			controller.addEventListener(ControllerEvent.SWIPE,onSwipe)
			
		}
		var tween;
		private function onControllerEvent(e:ControllerEvent):void
		{
			/*trace('--- controller event  -----')
			trace('type:',e.type);
			trace('gessture distance:',e.gessture.distance);
			trace('gessture distanceX:',e.gessture.distanceX);
			trace('gessture distanceY:',e.gessture.distanceY);
			trace('gessture length:',e.gessture.trackLength);
			trace('gessture duration:',e.gessture.duration);
			trace('gessture direction:',e.gessture.vectorDirection);
			trace('======================= \n');*/
			var X = trigger.x + e.gessture.lastStepX;
			var Y = trigger.y +e.gessture.lastStepY;
			if (tween)
			tween.kill();
			tween = TweenMax.to(trigger, 0.4, { x:X, y:Y } );
			
		}
		private function onTap(e:ControllerEvent):void
		{
			tf.text = 'TAP';
			trigger.graphics.clear();
			trigger.graphics.beginFill(Math.random()*0x999999);
			trigger.graphics.drawRect(0, 0,200,200);
			trigger.graphics.endFill();
		}
		private function onSwipe(e:ControllerEvent):void
		{
			tf.text = 'SWIPE: ' + e.gessture.vectorDirection;
		}
	}

}