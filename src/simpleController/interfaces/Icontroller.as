package simpleController.interfaces 
{
	import flash.display.InteractiveObject;
	
	/**
	 * ...
	 * @author 
	 */
	public interface Icontroller 
	{
		function set item(value:InteractiveObject):void
		function get item():InteractiveObject
		function get currentGess():Igessture
		
		function set enabled(value:Boolean):void
		function get enabled():Boolean
		
		function dispose():void
		function abortGess():void
		
		function addEventListener (type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false) : void;
		function removeEventListener (type:String, listener:Function, useCapture:Boolean=false) : void;
	}
	
}