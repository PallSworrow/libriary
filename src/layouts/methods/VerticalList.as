package layouts.methods 
{
	import com.greensock.TweenMax;
	import constants.AlignType;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import layouts.glifs.Glif;
	import layouts.glifs.GlifEvent;
	import layouts.glifs.Layout;
	import layouts.glifs.LayoutMethodBase;
	import layouts.GlifType;
	/**
	 * ...
	 * @author 
	 */
	public class VerticalList extends LayoutMethodBase
	{
		
		public function VerticalList() 
		{
			super();
			
		}
		override public function get triggerEventType():String 
		{
			return GlifEvent.HEIGHT_CHANGE;
		}
		override public function get glifType():String 
		{
			return GlifType.VERTICAL;
		}
		override public function update(target:DisplayObjectContainer, from:int = 0):void 
		{
			var currentLayout:DisplayObjectContainer = target;
			//main:
			var item:DisplayObject;
			var prev:DisplayObject;
			var L:int = currentLayout.numChildren;
			
			//suuported properties:
			var offsetX:int = properties.offsetX;
			var offsetY:int = properties.offsetY;
			var interval:int = properties.intervalY;
			var forceSize:Boolean = properties.forceSize;
			var fsOnlyGlifs:Boolean = properties.forceSizeIgnoreNonGlifs;
			var maxLineHeight:int = properties.maxLineHeight;
			var minLineHeight:int = properties.minLineHeight;
			var align:String = properties.alignX;
			var border:int = currentLayout.width;
			
			trace(this, 'from:',from, 'w:',border,JSON.stringify(properties));
			//start position:
			var x:int=offsetX;
			var y:int = offsetY;
			
			var lineHeight:int = 0;
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
					item.width = border;
				}
				
				lineHeight = item.height;
				if (maxLineHeight > 0 && lineHeight > maxLineHeight) lineHeight = maxLineHeight;
				if (minLineHeight > 0 && lineHeight < minLineHeight) lineHeight = minLineHeight;
				
				if(align == AlignType.CENTER)
				x = offsetX +(border - item.width) / 2;
				if (align == AlignType.RIGHT)
				x = offsetX+(border - item.width);
				
				item.x = x;
				item.y = y;
				y += lineHeight + interval;
				
			}
		}
		/*private function getLayoutHeight():int
		{
			if (!currentLayout) throw new Error("call method's submethod  bedor init");
			var item:DisplayObject = currentLayout.getChildAt(currentLayout.numChildren -1);
			var h:int =  item.height;
			if (properties.maxLineHeight > 0 && h > properties.maxLineHeight) h = properties.maxLineHeight;;
			if (properties.minLineHeight > 0 && h < properties.minLineHeight) h = properties.minLineHeight;
			return item.y + h;
		}*/
		
	}

}