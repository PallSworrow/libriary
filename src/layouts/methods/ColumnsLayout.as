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
	public class ColumnsLayout extends LayoutMethodBase 
	{
		private var _layoutMarkers:Array;
		
		public function ColumnsLayout() 
		{
			super();
			
		}
		override public function get triggerEventType():String 
		{
			return null;
		}
		override public function get glifType():String 
		{
			return GlifType.VERTICAL;
		}
		
		public function get layoutMarkers():Array 
		{
			return _layoutMarkers;
		}
		
		public function set layoutMarkers(value:Array):void 
		{
			if (!value) value = [];
			_layoutMarkers = value;
		}
		override public function update(from:int = 0):void 
		{
			
			var offset:int=0;
			var param:Object;
			var child:DisplayObject
			var padding:int;
			
			for (var i:int = 0; i < currentLayout.numChildren; i++) 
			{
				child = currentLayout.getChildAt(i);
				padding = 0;
				if (layoutMarkers)
				{
					if (i < layoutMarkers.length)
					{
						param = checkParam(layoutMarkers[i]);
						if (param.width is Number &&(child is Glif || !properties.forceSizeIgnoreNonGlifs))
						{
							child.width = param.width as Number;
						}
						
						if (param.paddingLeft is Number) 
						offset += param.paddingLeft as Number;
						
						trace(this, 'padding Right:', param.paddingRight);
						if (param.paddingRight is Number) 
						padding = param.paddingRight as Number;
					}
					//trace('param: ' + placeMethod[i]);
					//trace('aplWidth: ' + param.width);
				}
				child.x = offset;
				child.y = 0;
				offset = child.x + child.width+padding;
			}
		}
		private function get width():int
		{
			return currentLayout.width;
		}
		private function checkParam(param:Object):Object
		{
			trace(this, 'checkParam', JSON.stringify(param));
			if (!param) return { };
			
			var aplWidth:Object;
			var paddingLeft:int;
			var paddingRight:int;
			if (param is Number || param is String) aplWidth = readNumber(param, width);
			else
			{
				if (param.width) aplWidth =readNumber(param.width, width);
				if (param.paddingLeft) paddingLeft =readNumber(param.paddingLeft, width);
				if (param.paddingRight) paddingRight =readNumber(param.paddingRight, width);
			}
			var res:Object =  { width:aplWidth, paddingLeft:paddingLeft, paddingRight:paddingRight };
			return res;
			
			
			
		}
		private function readNumber(data:Object, appliement:int):int
		{
			var str:String;
			var def:String;
			var num:int;
			var res:int;
			switch(true)
			{
				case data is Number:
					res = data as Number;
					break;
				case data is String:
					str = String(data);
					def = str.substr( -1, 1);
					num = Number(str.substr(0, str.length - 1));
					if(!(num is Number))throw new Error('invalid param: ' + data);
					switch(def)
					{
						case '%':
							res = appliement * num / 100;
							break;
						case '-':
							res = appliement - num;
							break;
						default:
							throw new Error('invalid param: ' + data);
							break;
					}
					break;
				default:
					throw new Error('invalid param: ' + data);
					break;	
			}
			return res;
		}
	}

}