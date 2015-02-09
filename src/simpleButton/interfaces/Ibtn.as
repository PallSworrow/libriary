package simpleButton.interfaces 
{
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	
	/**
	 * ...
	 * @author 
	 */
	public interface Ibtn extends IEventDispatcher
	{
		function get behavior():IsingleButtonBehavior
		function get group():String
		function set group(value:String):void
		function set behavior(value:IsingleButtonBehavior):void
		function get name():String
		function tap(e:Event = null):void
		function get isActive():Boolean
		
	}
	
}