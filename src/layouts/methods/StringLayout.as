package layouts.methods 
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import layouts.glifs.GlifEvent;
	import layouts.glifs.Layout;
	import layouts.glifs.LayoutMethodBase;
	import layouts.GlifType;
	
	/**
	 * ...
	 * @author 
	 */
	public class StringLayout extends LayoutMethodBase 
	{
		
		public function StringLayout() 
		{
			super();
			
		}
		override public function get glifType():String 
		{
			return GlifType.VERTICAL;
		}
		override public function get triggerEventType():String 
		{
			return GlifEvent.SIZE_CHANGE;
		}
		override public function update(target:DisplayObjectContainer, from:int = 0):void 
		{
			var currentLayout:DisplayObjectContainer = target;
			from = 0;//always from 0 item
			var border:int= currentLayout.width;
			
			//supported props:
			var intervalX:int = properties.intervalX;
			var intervalY:int = properties.intervalY;
			var offsetX:int = properties.offsetX;
			var offsetY:int = properties.offsetY;
			var minWidth:int = properties.minColumnWidth;
			var minHeight:int = properties.minLineHeight;
			var maxWidth:int = properties.maxColumnWidth;
			var maxHeight:int = properties.maxLineHeight;
			
			
			//iteration vars:
			var item:DisplayObject;
			var lineheight:int = 0;
			var itemHeight:int; 
			var itemWidth:int;
			var x:int = offsetX;
			var y:int = offsetY;
			
			var resX:int;
			var resY:int;
			for (var i:int = from; i < currentLayout.numChildren ; i++) 
			{
				item = currentLayout.getChildAt(i);
				
				itemWidth = item.width;
				if (maxWidth > 0 && itemWidth > maxWidth) itemWidth = maxWidth;
				if (minWidth > 0 && itemWidth < minWidth) itemWidth = minWidth;
				
				itemHeight = item.height;
				if (maxHeight > 0 && itemHeight > maxHeight) itemHeight = maxHeight;
				if (minHeight > 0 && itemHeight < minHeight) itemHeight = minHeight;
				
				
				
				
				if (x + itemWidth > border)
				{
					if (x==offsetX)//first?
					{
						
						lineheight = itemHeight;
						resX = x;
						resY = y;
						
						x = offsetX;
						y += lineheight + intervalY;
					}
					else
					{
						x = offsetX;
						y += lineheight + intervalY;
						
						lineheight = itemHeight;
						resX = x;
						resY = y;
						
						x += itemWidth + intervalX;
						
					}
					//lineheight = 0;
				}
				else
				{
					if (lineheight < itemHeight) lineheight = itemHeight;
					resX = x;
					resY = y;
					
					x += itemWidth + intervalX;
				}
				item.x = resX;
				item.y = resY;
				
			}
		}
	}

}