package layouts.methods 
{
	import constants.AlignType;
	import flash.display.DisplayObject;
	import layouts.glifs.Glif;
	import layouts.glifs.GlifEvent;
	import layouts.glifs.LayoutMethodBase;
	import layouts.GlifType;
	
	/**
	 * ...
	 * @author 
	 */
	public class HorizontalList extends LayoutMethodBase 
	{
		
		public function HorizontalList() 
		{
			super();
			
		}
		override public function get triggerEventType():String 
		{
			return GlifEvent.WIDTH_CHANGE;
		}
		override public function get glifType():String 
		{
			return GlifType.HORIZONTAL;
		}
		override public function update(from:int = 0):void 
		{
			//trace(this, JSON.stringify(properties));
			//main:
			var item:DisplayObject;
			var prev:DisplayObject;
			var L:int = currentLayout.numChildren;
			
			//suuported properties:
			var offsetX:int = properties.offsetX;
			var offsetY:int = properties.offsetY;
			var interval:int = properties.intervalX;
			var forceSize:Boolean = properties.forceSize;
			var fsOnlyGlifs:Boolean = properties.forceSizeIgnoreNonGlifs;
			var maxColumnWidth:int = properties.maxColumnWidth;
			var minColumnWidth:int = properties.minColumnWidth;
			var align:String = properties.alignY;
			var border:int = currentLayout.height;
			
			//start position:
			var x:int=offsetX;
			var y:int = offsetY;
			var itemWidth:int = 0;
			try{prev = currentLayout.getChildAt(from - 1);}catch(e:Error){}
			if (prev)
			{
				x = prev.x;
				y = prev.y;
			}
			
			for (var i:int = from; i < L ; i++)
			{
				item = currentLayout.getChildAt(i);
				if (forceSize)//fit the size
				{
					if (!fsOnlyGlifs || item is Glif)
					item.height = border;
				}
				
				itemWidth = item.width;
				if (maxColumnWidth > 0 && itemWidth > maxColumnWidth) itemWidth = maxColumnWidth;
				if (minColumnWidth > 0 && itemWidth < minColumnWidth) itemWidth = minColumnWidth;
				
				if(align == AlignType.MIDDLE)
				y = offsetY+(border - item.height) / 2;
				if (align == AlignType.BOTTOM)
				y = offsetY+(border - item.height);
				
				item.x = x;
				item.y = y;
				x += itemWidth + interval;
				
			}
		}
		private function getLayoutWidth():int
		{
			if (!currentLayout) throw new Error("call method's submethod  bedor init");
			var item:DisplayObject = currentLayout.getChildAt(currentLayout.numChildren -1);
			var w:int =  item.width;
			if (properties.maxColumnWidth > 0 && w > properties.maxColumnWidth) w = properties.maxColumnWidth;
			if (properties.minColumnWidth > 0 && w < properties.minColumnWidth) w = properties.minColumnWidth;
			return item.x + w;
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