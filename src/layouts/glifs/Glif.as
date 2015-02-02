package layouts.glifs 
{
	import adobe.utils.CustomActions;
	import flash.display.Sprite;
	import flash.events.Event;
	import layouts.GlifType;
	
	/**
	 * ...
	 * @author 
	 */
	public class Glif extends Sprite 
	{
		private var _type:String = ''//GlifTypes: vertical(setting width dispatching height), horizontal, static(no setting sizes,  dispatch sizechange Event)
		private var _width:int=100;
		private var _height:int=100;
		public function Glif(type:String = null ) 
		{
			if(!type)
			type = GlifType.STATIC;
			glifType = type;
			super();
			
		}
		//PROTECTED:
		protected function updateMethod():void
		{
			
		}
		protected function get nativeWidth():int
		{
			return super.width;
		}
		protected function get nativeHeight():int
		{
			return super.height;
		}
	
		//PUBLIC:
		public function dispatchSizeChange():void
		{
			if (glifType == GlifType.HORIZONTAL || glifType == GlifType.STATIC) dispatchEvent(new GlifEvent(GlifEvent.WIDTH_CHANGE));
			if (glifType == GlifType.VERTICAL || glifType == GlifType.STATIC) dispatchEvent(new GlifEvent(GlifEvent.HEIGHT_CHANGE));
			if (glifType != GlifType.DYNAMIC)
			dispatchEvent(new GlifEvent(GlifEvent.SIZE_CHANGE));
		}
		override public function set width(value:Number):void 
		{
			if(glifType ==  GlifType.VERTICAL || glifType == GlifType.DYNAMIC)
			{
				_width = value;
				updateMethod();
			}
			//super.width = value;
		}
		override public function set height(value:Number):void 
		{
			if(glifType ==  GlifType.HORIZONTAL ||  glifType == GlifType.DYNAMIC)
			{
				_height = value;
				updateMethod();
			}
			//super.height = value;
		}
		
		override public function get width():Number 
		{
			if(glifType == GlifType.VERTICAL ||  glifType == GlifType.DYNAMIC)
			return _width;
			else
			return super.width;
		}
		override public function get height():Number 
		{
			if(glifType == GlifType.HORIZONTAL ||  glifType == GlifType.DYNAMIC)
			return _height;
			else
			return super.height;
		}
		
		protected function get glifType():String 
		{
			return _type;
		}
		
		protected function set glifType(value:String):void 
		{
			if (!GlifType.validate(value)) throw new Error('Invalid glif type');
			_type = value;
		}
		
		
	}

}