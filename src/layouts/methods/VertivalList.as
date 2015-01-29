package layouts.methods 
{
	import flash.display.DisplayObject;
	import layouts.glifs.Glif;
	import layouts.glifs.GlifEvent;
	import layouts.glifs.LayoutMethodBase;
	import layouts.GlifType;
	/**
	 * ...
	 * @author 
	 */
	public class VertivalList extends LayoutMethodBase 
	{
		
		public function VertivalList() 
		{
			super();
			
		}
		override public function get triggerEventType():String 
		{
			return GlifEvent.HEIGHT_CHANGE;
		}
		override public function get type():String 
		{
			return GlifType.VERTICAL;
		}
		override public function update(from:int = 0):void 
		{
			//trace(this, JSON.stringify(properties));
			//main:
			var item:DisplayObject;
			var prev:DisplayObject;
			var L:int = currentLayout.numChildren;
			
			//params:
			var offsetX:int = properties.offsetX;
			var offsetY:int = properties.offsetY;
			var interval:int = properties.intervalY;
			var forceSize:Boolean = properties.forceSize;
			var fsOnlyGlifs:Boolean = properties.forceSizeIgnoreNonGlifs;
			var maxLineHeight:int = properties.maxLineHeight;
			var border:int = currentLayout.width;
			
			//start position:
			var x:int=offsetX;
			var y:int = offsetY;
			var lineHeight:int = 0;
			try{prev = currentLayout.getChildAt(from - 1);}catch(e:Error){}
			if (prev)
			{
				offsetX = prev.x;
				offsetY = prev.y;
			}
			
			
			
			for (var i:int = from; i < L ; i++) 
			{
				item = currentLayout.getChildAt(i);
				if (forceSize)
				{
					if (!fsOnlyGlifs || item is Glif)
					item.width = border;
				}
				
				lineHeight = item.height;
				if (maxLineHeight > 0 && lineHeight > maxLineHeight) lineHeight = maxLineHeight;
				
				item.x = x;
				item.y = y;
				y += lineHeight + interval;
				
			}
		}
		private function getLayoutWidth():int
		{
			if (!currentLayout) throw new Error("call method's submethod  bedor init");
			var item:DisplayObject = currentLayout.getChildAt(currentLayout.numChildren -1);
			return item.y + item.height;
		}
		override public function get widthGetter():Function 
		{
			if (properties.overrideSizeGetters)
			return getLayoutWidth;
			else
			return null;
		}
	}

}