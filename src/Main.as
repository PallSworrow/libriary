package 
{
	import adobe.utils.CustomActions;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import simpleController.Controller;
	import simpleController.events.ControllerEvent;
	
	
	/**
	 * ...
	 * @author 
	 */
	public class Main extends Sprite 
	{
		
		public function Main():void 
		{
			var sprite:Sprite = new Sprite();
			sprite.graphics.beginFill(0x234433, 1);
			sprite.graphics.drawRect(0, 0, 100, 100);
			sprite.graphics.endFill();
			
			var ctrl:Controller = new Controller(sprite);
			//ctrl.addEventListener(ControllerEvent.TAP, handler);
			//ctrl.addEventListener(ControllerEvent.SWIPE, handler);
			//ctrl.addEventListener(ControllerEvent.GESSTURE_START, handler);
			ctrl.addEventListener(ControllerEvent.GESSTURE_UPDATE, handler);
			//ctrl.addEventListener(ControllerEvent.GESSTURE_COMPLETE, handler);
			
			var box:Sprite = new Sprite();
			box.x = 100;
			box.y = 100;
			box.addChild(sprite);
			addChild(box);
		}
		
		private function handler(e:ControllerEvent):void 
		{
			e.controller.item.x += e.gessture.lastStepX;
			e.controller.item.y += e.gessture.lastStepY;
			
		}
		
		
		
	}
	
}