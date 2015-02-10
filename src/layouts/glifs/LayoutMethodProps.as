package layouts.glifs 
{
	import constants.AlignType;
	import simpleTools.TypeDescriptor;
	/**
	 * ...
	 * @author 
	 */
	public class LayoutMethodProps 
	{
		//position params:
		public var intervalX:int=0;
		public var intervalY:int=0;
		public var offsetX:int=0;
		public var offsetY:int = 0;
		private var _alignX:String = AlignType.LEFT;
		private var _alignY:String = AlignType.TOP;
		
		//layout width|height modifying:
		public var minLineHeight:int=-1;
		public var minColumnWidth:int=-1;
		public var maxLineHeight:int=-1;
		public var maxColumnWidth:int=-1;
		public var overrideSizeGetters:Boolean = false;
		public var forceSize:Boolean=true;
		public var forceSizeIgnoreNonGlifs:Boolean = true;
		
		
		//tweenMax:
		private var snapDuration:Number=0;
		//public var snapMethod:String;	//tween max ease function
		
		public function LayoutMethodProps(data:Object=null) 
		{
			if (data) parseParams(data);
		}
		public function parseParams(data:Object):void
		{
			var inst:Object = this;
			if (data is String) data = JSON.parse(String(data));
			if (data)
			{
				TypeDescriptor.iterateVars(this, parser);
			}
			
			
			function parser(name:String,type:Class):void
			{
				if (data[name] || data[name] is Number ||  data[name] is Boolean)
				inst[name] = type(data[name]);
			}
		}
		//SETTERS:
		
		public function set alignX(value:String):void 
		{
			if (!AlignType.validateHorizontal(value))
			value == AlignType.LEFT;
			_alignX = value;
		}
		public function set alignY(value:String):void 
		{
			if (!AlignType.validateVertical(value))
			value == AlignType.TOP;
			_alignY = value;
		}
	/*	public function set minColumnWidth(value:int):void 
		{
			_minColumnWidth = value;
		}
		public function set minLineHeight(value:int):void 
		{
			_minLineHeight = value;
		}
		public function set maxLineHeight(value:int):void 
		{
			_maxLineHeight = value;
		}
		public function set maxColumnWidth(value:int):void 
		{
			_maxColumnWidth = value;
		}*/
		//GETTERS:
		
		public function get alignX():String 
		{
			return _alignX;
		}
		public function get alignY():String 
		{
			return _alignY;
		}
		/*public function get minColumnWidth():int 
		{
			return _minColumnWidth;
		}
		public function get minLineHeight():int 
		{
			
			return _minLineHeight;
		}
		public function get maxLineHeight():int 
		{
			return _maxLineHeight;
		}
		public function get maxColumnWidth():int 
		{
			return _maxColumnWidth;
		}*/
		
		
		
		
		
	}

}