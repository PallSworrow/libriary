package layouts.methods 
{
	import _examples.ControllerExample;
	import constants.AlignType;
	import flash.display.DisplayObject;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import layouts.glifs.GlifEvent;
	import layouts.glifs.LayoutMethodBase;
	import layouts.GlifType;
	
	/**
	 * ...
	 * @author 
	 */
	public class TagsLayout extends LayoutMethodBase 
	{
		
		private var markers:Dictionary;//{x:{value:number|displayObjet|String, align:AlignType, offset:number},
		public function TagsLayout() 
		{
			super();
			markers = new Dictionary();
		}
		public function addMarker(name:String, x:Object, y:Object):void
		{
			markers[name] = { x:x, y:y };
		}
		public function deleteMarker(name:String):void
		{
			delete markers[name];
		}
		//OVERRIDES:
		
		override public function get triggerEventType():String 
		{
			return GlifEvent.HEIGHT_CHANGE;
		}
		override public function get glifType():String 
		{
			return GlifType.DYNAMIC;
		}
		override public function update(from:int = 0):void 
		{
			//props defines only defaults:
			//var defAlignX:String = properties.alignX;
			//var defAlignY:String = properties.alignY;
			
			
			var item:DisplayObject;//checked item
			var mk:Object;//element of markers list
			var res:Point;
			trace(this, 'update');
			for (var i:int = 0; i < currentLayout.numChildren; i++) 
			{
				item = currentLayout.getChildAt(i);
				trace(item);
				mk = markers[item.name];
				if (mk)
				{
					res = getPos(mk.x, mk.y, item);
				}
				else res = new Point();
				
				item.x = res.x;
				item.y = res.y;
			}
			
			
		}
		//RPIVATE
		private function getPos(markerX:Object, markerY:Object,item:DisplayObject):Point
		{
			var res:Point = new Point();
			var value:Object;//x|y value
			var align:String;//x/y align
			var offset:int//x/y offset
			var size:int;
			
			///get X:
			if (markerX is Number) res.x = markerX as Number;
			else if (markerX)
			{
				value = markerX.value;
				if (value is String) value = currentLayout.getChildByName(String(value));
				if (value is DisplayObject)
				{
					size = value.width;
					value = value.x;
				}
				else size = 0;
				if (!(value is Number))
				value = 0;
				
				offset = markerX.offset;
				if (!(offset is Number)) offset == 0;
				
				align = markerX.align;
				if (!AlignType.validateHorizontal(align)) align = AlignType.AFTER;
				switch(align)
				{
					case AlignType.BEFORE:
						res.x = Number(value)-offset;
						break;
					case AlignType.LEFT:
						res.x = Number(value)+offset;
						break;
					case AlignType.CENTER:
						res.x = Number(value)+offset + (size-item.width) / 2;
						break;
					case AlignType.RIGHT:
						res.x = Number(value)+offset + size-item.width;
						break;
					case AlignType.AFTER:
						res.x = Number(value)+offset + size;
						break;
					default:
						throw new Error('invalid x align type: ' + align);
						break;
				}
			}
			//GET Y:
			if (markerY is Number) res.y = Number(markerY);
			else if (markerY)
			{
				value = markerY.value;
				if (value is String) value = currentLayout.getChildByName(String(value));
				if (value is DisplayObject)
				{
					size = value.height;
					value = value.y;
				}
				else size = 0;
				if (!(value is Number))
				value = 0;
				
				offset = markerY.offset;
				if (!(offset is Number)) offset == 0;
				
				align = markerY.align;
				if (!AlignType.validateVertical(align)) align = AlignType.UNDER;
				switch(align)
				{
					case AlignType.ABOVE:
						res.y = Number(value)-offset;
						break;
					case AlignType.TOP:
						res.y = Number(value)+offset;
						break;
					case AlignType.MIDDLE:
						res.y = Number(value)+offset + (size-item.height) / 2;
						break;
					case AlignType.BOTTOM:
						res.y = Number(value)+offset + size-item.height;
						break;
					case AlignType.UNDER:
						res.y = Number(value)+offset + size;
						break;
					default:
						throw new Error('invalid y align type: ' + align);
						break;
				}
			}
			//RETURN
			return res;
		}
	}

}