package 
{
	import layouts.glifs.LayoutMethodBase;
	import layouts.glifs.LayoutMethodProps;
	import adobe.utils.CustomActions;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import flash.text.TextField;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import flash.utils.setInterval;
	import layouts.glifs.Glif;
	import layouts.glifs.GlifEvent;
	import layouts.glifs.Layout;
	import layouts.GlifType;
	import layouts.methods.VertivalList;
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
		private var layout:Layout
		
		public function Main():void 
		{ 
			layout = new Layout();
			addChild(layout);
			
			var obj:DisplayObject
			for (var i:int = 0; i < 10; i++) 
			{
				obj = glifFactory();
				
				//trace('CREATE', obj.height);
				layout.addChild(obj);
			}
			layout.method = new VertivalList();
		/*	
			setInterval(function()
			{
				var item:Sprite = layout.getChildAt(Math.floor(Math.random()*layout.numChildren)) as Sprite;
				item.graphics.clear();
				item.graphics.beginFill(Math.random() * 0xdddddd);
				item.graphics.drawRect(0, 0, Math.random() * 60 + 60, Math.random() * 60 + 60);
				item.graphics.endFill();
				item.dispatchEvent(new GlifEvent(GlifEvent.HEIGHT_CHANGE));
			},1000);*/
			addEventListener(MouseEvent.CLICK, click);
			trace(layout.height);
		
			
		}
		
		private function click(e:MouseEvent):void 
		{
			var params:LayoutMethodProps = new LayoutMethodProps();
			//params.intervalY = 10;
			params.forceSizeIgnoreNonGlifs = true;
			params.forceSize = true;
			params.maxLineHeight = 60;
			params.overrideSizeGetters = true;
			layout.method.properties = params;
			trace('CLICK');
			trace(layout.height);
		}
			
		private function glifFactory():Sprite
		{
			var res:Sprite = new Sprite();
			res.graphics.beginFill(Math.random() * 0xdddddd);
			res.graphics.drawRect(0, 0, Math.random() * 60 + 60, Math.random() * 60 + 60);
			res.graphics.endFill();
			return res;
			
		}
		
	}
	
}