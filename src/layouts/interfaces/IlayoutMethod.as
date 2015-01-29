package layouts.interfaces 
{
	import layouts.glifs.Layout;
	import layouts.glifs.LayoutMethodProps;
	
	/**
	 * ...
	 * @author 
	 */
	public interface IlayoutMethod 
	{
		/**
		 * Glif item type that will be applied to target layout
		 */
		function get type():String
		function get triggerEventType():String
		function init(target:Layout):void
		function dispose():void
		function update(from:int = 0):void
		function get properties():LayoutMethodProps 
		function set properties(value:LayoutMethodProps):void
		function get  widthGetter():Function
		function get  heightGetter():Function
	
		
	}
	
}