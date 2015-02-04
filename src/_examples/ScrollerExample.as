package _examples 
{
	import constants.AlignType;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import layouts.glifs.Layout;
	import layouts.glifs.LayoutMethodProps;
	import layouts.methods.HorizontalList;
	import layouts.methods.StringLayout;
	import layouts.methods.VerticalList;
	import scrollers.bases.ScrollBar;
	import scrollers.bases.ScrollContainer;
	import scrollers.bases.ScrollViewBase;
	import scrollers.ScrollController;
	
	/**
	 * ...
	 * @author 
	 */
	public class ScrollerExample extends Sprite 
	{
		private var scrollBox:ScrollContainer;
		private var sb:ScrollBar;
		private var controller:ScrollController;
		private var index:int = 0;
		public function ScrollerExample() 
		{
			super();
			controller = new ScrollController();
			scrollBox = new ScrollContainer();
			scrollBox.width = 400;
			scrollBox.height = 500;
			addChild(scrollBox);
			
			var obj:DisplayObject;
			for (var i:int = 0; i < 10; i++) 
			{
				obj = glifFactory();
				scrollBox.layout.addChild(obj);
			}
			
			sb = new ScrollBar();
			sb.height = 400;
			addChild(sb);
			sb.x = scrollBox.width;
			sb.controller = controller;
			var bg:Sprite = new Sprite();
			bg.graphics.beginFill(0x999999);
			bg.graphics.drawRect(0, 0, 100, 100);
			bg.graphics.endFill();
			sb.background = bg;
			
			//layout.width = 300;
			scrollBox.layout.method = new VerticalList();
			scrollBox.layout.method.properties.alignX = AlignType.CENTER;
			scrollBox.layout.method.update();
			
			scrollBox.controller = controller;
			
			//scrollBox.scrollTo(1, 2);
			
			graphics.lineStyle(1, 0x000000);
			graphics.drawRect(scrollBox.x, scrollBox.y, scrollBox.width, scrollBox.height);
			
			controller.snapHandler = scrollBox;
			addEventListener(MouseEvent.CLICK, click);
			
		}
		
		private function click(e:MouseEvent):void 
		{
			//trace(scrollBox.getNearestPageOffset(),scrollBox.getNearestPagePosition());
			//controller.snap();
		}
		
		
			
		private function glifFactory():Sprite
		{
			var res:Sprite = new Sprite();
			res.graphics.beginFill(Math.random() * 0xdddddd,0.6);
			res.graphics.drawRect(0, 0, /*int(Math.random() * 60) + */100, /*int(Math.random() * 60) +*/ 100);
			res.graphics.endFill();
			return res;
			
		}
	}

}