package scrollers.interfaces 
{
	import flash.events.IEventDispatcher;
	import scrollers.propsObjects.ScrollerViewProperies;
	import scrollers.ScrollController;
	
	/**
	 * интерефейс для любых scrollerView
	 * @author 
	 */
	public interface Iscroller extends IEventDispatcher
	{
		function get position():Number 
		function set position(value:Number):void 
		
		function set controller(value:ScrollController):void 
		function get controller():ScrollController 
		
		function get draggable():Boolean 
		function set draggable(value:Boolean):void 
		
		function get offset():int 
		function set offset(value:int):void 
		
		function get isVertical():Boolean
		function get maxOffset():int 
		function get proportion():Number 
			
		function get props():ScrollerViewProperies 
		function set props(value:ScrollerViewProperies):void 
		
		function scrollTo(position:Number, duration:Number, onComplete:Function = null):void
		
	}
	
}