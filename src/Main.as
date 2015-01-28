package 
{
	import adobe.utils.CustomActions;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import flash.text.TextField;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import popupManager.Popup;
	import popupManager.PopupEngine;
	import simpleController.Controller;
	import simpleController.events.ControllerEvent;
	import simpleController.events.MultitouchEvent;
	import simpleController.MultitouchController;
	
	
	/**
	 * ...
	 * @author 
	 */
	public class Main extends Sprite 
	{
		private var tf:TextField;
		
		public function Main():void 
		{
			Multitouch.inputMode=MultitouchInputMode.TOUCH_POINT;
			var sprite:Sprite = new Sprite();
			sprite.graphics.beginFill(0x234433, 1);
			sprite.graphics.drawRect(0, 0, 200, 200);
			sprite.graphics.endFill();
			
			var ctrl:Controller = new MultitouchController(sprite);
			//ctrl.addEventListener(ControllerEvent.TAP, handler);
			//ctrl.addEventListener(ControllerEvent.SWIPE, handler);
			//ctrl.addEventListener(ControllerEvent.GESSTURE_START, handler);
			ctrl.addEventListener(MultitouchEvent.DRAGGING, handler);
			//ctrl.addEventListener(ControllerEvent.GESSTURE_COMPLETE, handler);
			
			var box:Sprite = new Sprite();
			box.x = 100;
			box.y = 100;
			box.addChild(sprite);
			addChild(box);
			
			tf = new TextField();
			addChild(tf);
			tf.autoSize = 'center';
			
			addEventListener(TouchEvent.TOUCH_BEGIN, touchBegin);
			
			PopupEngine.init(800, 600, this);
			
			var s:Sprite = new Sprite();
			s.graphics.beginFill(0xdf1f55, 1);
			s.graphics.drawRect(100, 0, 200, 200);
			s.graphics.endFill();
			
			var popup:Popup = new Popup(s);
			popup.show();
		}
		
		private function touchBegin(e:TouchEvent):void 
		{
			tf.appendText('TOUCH BEGIN \n');
		}
		
		private function handler(e:MultitouchEvent):void 
		{
			e.controller.item.x += e.gessture.lastStepX;
			e.controller.item.y += e.gessture.lastStepY;
			tf.text = String(e.gessture.numTouches)+'\n';
			
			
		}
		
		
		
	}
	
}