package simpleButton.interfaces 
{
	import flash.events.IEventDispatcher;
	
	/**
	 * ...
	 * @author 
	 */
	public interface IbuttonController extends IEventDispatcher
	{
		function tap():void
		function togleActivate():void
		function togleDesactivate():void
		function get method():IsingleButtonBehavior
		function set method(value:IsingleButtonBehavior):void
	}
	
}