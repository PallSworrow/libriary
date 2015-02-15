package layouts.interfaces 
{
	import flash.display.DisplayObjectContainer;
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
		function get glifType():String
		function get triggerEventType():String
		//function init(target:Layout):void
		function dispose():void
		function update(target:DisplayObjectContainer,from:int = 0):void
		function get properties():LayoutMethodProps 
		function set properties(value:LayoutMethodProps):void
		function getWidth(target:DisplayObjectContainer):int
		function getHeight(target:DisplayObjectContainer):int
	
		
	}
	
}