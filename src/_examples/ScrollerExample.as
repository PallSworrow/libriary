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
	import layouts.methods.VertivalList;
	import scrollers.bases.ScrollBox;
	import scrollers.bases.ScrollViewBase;
	import scrollers.ScrollController;
	
	/**
	 * ...
	 * @author 
	 */
	public class ScrollerExample extends Sprite 
	{
		private var scrollBox:ScrollBox;
		private var layout:Layout;
		private var methods:Array;
		private var index:int = 0;
		public function ScrollerExample() 
		{
			super();
			scrollBox = new ScrollBox();
			addChild(scrollBox);
			
			var obj:DisplayObject;
			for (var i:int = 0; i < 10; i++) 
			{
				obj = glifFactory();
				scrollBox.layout.addChild(obj);
			}
			layout = scrollBox.layout;
		
			methods = [new VertivalList(), new HorizontalList(), new StringLayout()];
			
		
			layout.width = 300;
			layout.method = methods[0];
			
			scrollBox.controller = new ScrollController();
			
			scrollBox.controller.scrollTo(1, 2);
		
			
		}
		
		private function click(e:MouseEvent):void 
		{
			
			var params:LayoutMethodProps = new LayoutMethodProps({intervalX:10});
			params.intervalY = 10;
			params.alignX = AlignType.RIGHT;
			params.parseParams('{"minLineHeight":"100"}');
			
			index++;
			if (index == methods.length) index = 0;
			layout.method = methods[index];
			layout.method.properties = params;
			trace('CLICK');
		}
			
		private function glifFactory():Sprite
		{
			var res:Sprite = new Sprite();
			res.graphics.beginFill(Math.random() * 0xdddddd,0.6);
			res.graphics.drawRect(0, 0, Math.random() * 60 + 60, Math.random() * 60 + 60);
			res.graphics.endFill();
			return res;
			
		}
	}

}