package layouts.methods 
{
	import flash.display.DisplayObject;
	import layouts.glifs.GlifEvent;
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
		override public function update(from:int = 0):void 
		{
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
			trace(JSON.stringify(properties));
			trace('border:', border);
			
			var resX:int;
			var resY:int;
			for (var i:int = from; i < currentLayout.numChildren ; i++) 
			{
				item = currentLayout.getChildAt(i);
				
				itemWidth = item.width;
				//if (maxWidth > 0 && itemWidth > maxWidth) itemWidth = maxWidth;
				//if (minWidth > 0 && itemWidth < minWidth) itemWidth = minWidth;
				
				itemHeight = item.height;
				//if (maxHeight > 0 && itemHeight > maxHeight) itemHeight = maxHeight;
				//if (minHeight > 0 && itemHeight < minHeight) itemHeight = minHeight;
				
				
				
				trace('PLACE ITEM', i);
				trace('size: ' + itemWidth, itemHeight);
				trace('offset: ' + x, y);
				trace('lineHeight: ' + lineheight);
				
				if (x + itemWidth > border)
				{
					if (x==offsetX)//first?
					{
						trace('bigger then layout width');
						
						lineheight = itemHeight;
						resX = x;
						resY = y;
						
						x = offsetX;
						y += lineheight + intervalY;
					}
					else
					{
						trace('new line');
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
					trace('next');
					if (lineheight < itemHeight) lineheight = itemHeight;
					resX = x;
					resY = y;
					
					x += itemWidth + intervalX;
				}
				trace('res pos:', resX, resY,x,y);
				item.x = resX;
				item.y = resY;
				
			}
		}
	}

}