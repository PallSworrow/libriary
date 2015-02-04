package Swarrow.models.screenManager.interfaces 
{
	import flash.display.DisplayObjectContainer;
	import flash.events.IEventDispatcher;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author pall
	 */
	public interface Iscreen extends IEventDispatcher 
	{
		function show(container:DisplayObjectContainer, params:Object, manager:IscreenManager):void
		function hide():void
		
		function load(data:Object = null):void
		function clear():void
		
		
	}
	
}