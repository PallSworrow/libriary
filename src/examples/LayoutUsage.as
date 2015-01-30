package examples 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.utils.setInterval;
	import layouts.methods.StringLayout;
	
	//dependencies:
	import constants.AlignType;
	import layouts.glifs.GlifEvent;
	import layouts.glifs.Layout;
	import layouts.glifs.LayoutMethodProps;
	import layouts.interfaces.IlayoutMethod;
	import layouts.methods.HorizontalList;
	import layouts.methods.VertivalList;
	
	/**
	 * ...
	 * @author 
	 */
	public class LayoutUsage extends Sprite 
	{
		private var layout:Layout;
		private var methods:Array;
		private var index:int = 0;
		public function LayoutUsage() 
		{
			super();
			layout = new Layout();
			addChild(layout);
			
			var obj:DisplayObject;
			for (var i:int = 0; i < 10; i++) 
			{
				obj = glifFactory();
				layout.addChild(obj);
			}
			methods = [new VertivalList(), new HorizontalList(), new StringLayout()];
			layout.method = new StringLayout();
			layout.width = 300;
			layout.method = methods[0];
			//*
			setInterval(function()
			{
				var item:Sprite = layout.getChildAt(Math.floor(Math.random()*layout.numChildren)) as Sprite;
				item.graphics.clear();
				item.graphics.beginFill(Math.random() * 0xdddddd);
				item.graphics.drawRect(0, 0, Math.random() * 60 + 60, Math.random() * 60 + 60);
				item.graphics.endFill();
				item.dispatchEvent(new GlifEvent(GlifEvent.HEIGHT_CHANGE));
				item.dispatchEvent(new GlifEvent(GlifEvent.SIZE_CHANGE));
				item.dispatchEvent(new GlifEvent(GlifEvent.WIDTH_CHANGE));
				trace(layout.width);
			},1000);//*/
			addEventListener(MouseEvent.CLICK, click);
		
			
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