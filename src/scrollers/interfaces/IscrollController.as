package scrollers.interfaces 
{
	import flash.events.IEventDispatcher;
	import scrollers.propsObjects.ScrollProperties;
	
	/**
	 * ...
	 * @author pall
	 */
	public interface IscrollController extends IEventDispatcher
	{
		
		function scrollTo(pos:Number, duration:Object=0, onComplete:Function=null,trigger:Object = 'external', noSnap:Boolean = false):void
		function get position():Number 
		function set position(value:Number):void 
		function get props():ScrollProperties 
		function set props(value:ScrollProperties):void 
		function snap(onComplete:Function=null):void
	}
	
}