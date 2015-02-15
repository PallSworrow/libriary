package layouts.glifs 
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import layouts.glifs.GlifEvent;
	import layouts.glifs.Layout;
	import layouts.GlifType;
	import layouts.interfaces.IlayoutMethod;
	
	/**
	 * ...
	 * @author 
	 */
	public class LayoutMethodBase implements IlayoutMethod 
	{
		
		private var _properties:LayoutMethodProps;
		public function LayoutMethodBase() 
		{
			_properties = new LayoutMethodProps();
		}
		
		/* INTERFACE layouts.interfaces.IlayoutMethod */
		
		public function get glifType():String 
		{
			throw 'must be overrided';
			return null;
		}
		
		public function get triggerEventType():String 
		{
			throw 'must be overrided';
			return null;
		}
		
		
		
		public function set properties(value:LayoutMethodProps):void 
		{
			_properties = value;
			if (!_properties) _properties = new LayoutMethodProps();
		}
		
		
		public function dispose():void 
		{
			
		}
		
		/* INTERFACE layouts.interfaces.IlayoutMethod */
		
		public function update(target:DisplayObjectContainer, from:int = 0):void 
		{
			
		}
		
		/* INTERFACE layouts.interfaces.IlayoutMethod */
		
		public function get properties():LayoutMethodProps 
		{
			return _properties;
		}
		
		public function getWidth(target:DisplayObjectContainer):int 
		{
			return target.width;
		}
		
		public function getHeight(target:DisplayObjectContainer):int 
		{
			return target.width;
		}
		
		
		
		
		
	}

}