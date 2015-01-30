package layouts.glifs 
{
	import flash.display.DisplayObject;
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
		private var _currentLayout:Layout;
		
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
		
		
		public function get currentLayout():Layout 
		{
			return _currentLayout;
		}
		
		public function get properties():LayoutMethodProps 
		{
			return _properties;
		}
		
		public function set properties(value:LayoutMethodProps):void 
		{
			_properties = value;
			if (!_properties) _properties = new LayoutMethodProps();
			if (currentLayout) update();
		}
		
		public function init(target:Layout):void 
		{
			if (_currentLayout) dispose();
			_currentLayout = target;
			if (!_currentLayout) throw new Error('parameter must be not null');
			update(0);
		}
		
		public function dispose():void 
		{
			
		}
		
		public function update(from:int = 0):void 
		{
			throw 'must be overrided';
		}
		
		/* INTERFACE layouts.interfaces.IlayoutMethod */
		
		public function get widthGetter():Function 
		{
			return null;
		}
		
		public function get heightGetter():Function 
		{
			return null;
		}
		
		
		
	}

}