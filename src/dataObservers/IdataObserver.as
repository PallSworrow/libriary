package dataObservers {
	import flash.events.IEventDispatcher;
	
	/**
	 * ...
	 * @author pall
	 */
	public interface IdataObserver extends IEventDispatcher
	{
		function addListener(handler:Function):void
		function removeListener(handler:Function):void
	}
	
}