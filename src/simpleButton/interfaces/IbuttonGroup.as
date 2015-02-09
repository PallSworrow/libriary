package simpleButton.interfaces 
{
	
	/**
	 * ...
	 * @author 
	 */
	public interface IbuttonGroup 
	{
		function addBtn(btn:Ibtn):void
		function removeBtn(selector:Object):void
		function getBtn(selector:Object):Ibtn 
		function get length():int
		function tap(selector:Object):void
		function clear():void
		function get name():String
		function get method():IbuttonGroupBehavior
		function set method(value:IbuttonGroupBehavior):void
	}
	
}